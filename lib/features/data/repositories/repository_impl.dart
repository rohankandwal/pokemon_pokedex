import 'package:byzat_pokemon/core/error/exceptions.dart';
import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/network/network_info.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/core/utils/extension_function.dart';
import 'package:byzat_pokemon/features/data/datasource/local_datasource.dart';
import 'package:byzat_pokemon/features/data/datasource/remote_datasource.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Future<PokemonDetailEntity>>>> getAllPokemons(
      {required final int offset}) async {
    try {
      if (await networkInfo.isConnected) {
        final data = await remoteDataSource.getAllPokemons(offset: offset);
        final List<Future<PokemonDetailEntity>> pokemonItems = data.results
            .map((e) => remoteDataSource
                    .getPokemonByNameOrId(idOrName: e.name)
                    .then((value) {
                  String type = "";
                  for (var element in value.types) {
                    type = type +
                        element.type.name
                            .capitalizeFirstOfEach()
                            .optimizeString() +
                        ", ";
                  }
                  if (type.isNotEmpty) {
                    type = type.substring(0, type.length - 2);
                  }
                  final List<PokemonDetailStatsEntity> stats = value.stats
                      .map((e) => PokemonDetailStatsEntity(
                          baseStat: e.baseStats,
                          effort: e.effort,
                          name: e.stat.name))
                      .toList();
                  return PokemonDetailEntity(
                    name: value.name.capitalizeFirstOfEach().optimizeString(),
                    id: value.id,
                    type: type,
                    imageUrl: value.sprites.other.officialArtwork.frontDefault,
                    height: value.height,
                    weight: value.weight,
                    stats: stats,
                  );
                }))
            .toList();
        return Right(pokemonItems);
      } else {
        return Left(ServerFailure(message: Constants.internetErrorOccurred));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> addPokemonToFavorite(
      {required final PokemonDetailEntity data}) async {
    localDataSource.addPokemonToFavorite(data: data);
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> checkPokemonFavorite(
      {required final int data}) async {
    return Right(await localDataSource.checkPokemonFavorite(data: data));
  }

  @override
  Future<Either<Failure, bool>> removePokemonFavorite(
      {required final int data}) async {
    return Right(await localDataSource.removePokemonFavorite(data: data));
  }

  @override
  Future<Either<Failure, Stream<List<PokemonDetailEntity>>>>
      getAllFavoritePokemonsStream() async {
    return Right(await localDataSource.getAllFavoritePokemonsStream());
  }

  @override
  Future<Either<Failure, List<PokemonDetailEntity>>>
      getAllFavoritePokemons() async {
    final favoritePokemons = await localDataSource.getAllFavoritePokemons();

    /// Sending cached information and fetching latest information from server
    /// since the database is reactive, latest information will always be displayed
    /// once the record is updated in db
    for (var pokemon in favoritePokemons) {
      updateFavoritePokemonRecord(pokemonName: pokemon.name);
    }
    return Right(favoritePokemons);
  }

  @override
  void updateFavoritePokemonRecord({required final String pokemonName}) async {
    final value =
        await remoteDataSource.getPokemonByNameOrId(idOrName: pokemonName);
    String type = "";
    for (var element in value.types) {
      type = type +
          element.type.name.capitalizeFirstOfEach().optimizeString() +
          ", ";
    }
    if (type.isNotEmpty) {
      type = type.substring(0, type.length - 2);
    }
    final List<PokemonDetailStatsEntity> stats = value.stats
        .map((e) => PokemonDetailStatsEntity(
            baseStat: e.baseStats, effort: e.effort, name: e.stat.name))
        .toList();
    addPokemonToFavorite(
        data: PokemonDetailEntity(
      name: value.name.capitalizeFirstOfEach().optimizeString(),
      id: value.id,
      type: type,
      imageUrl: value.sprites.other.officialArtwork.frontDefault,
      height: value.height,
      weight: value.weight,
      stats: stats,
    ));
  }
}
