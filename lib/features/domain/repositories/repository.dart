import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  /// Function used to fetch list of all the pokemons from server
  Future<Either<Failure, List<Future<PokemonDetailEntity>>>> getAllPokemons(
      {required final int offset});

  /// Function used to add a pokemon to favorite
  Future<Either<Failure, bool>> addPokemonToFavorite(
      {required final PokemonDetailEntity data});

  /// Function used to check if a pokemon is already added to favorite
  Future<Either<Failure, bool>> checkPokemonFavorite({required int data});

  /// Function used to remove pokemon from favorite
  Future<Either<Failure, bool>> removePokemonFavorite({required int data});

  /// Function used to get the stream of all favorite Pokemons
  Future<Either<Failure, Stream<List<PokemonDetailEntity>>>>
      getAllFavoritePokemonsStream();

  /// Function used to get all the list of favorite Pokemons
  Future<Either<Failure, List<PokemonDetailEntity>>> getAllFavoritePokemons();

  /// Function used to get the updated pokemons pokemon information from server
  void updateFavoritePokemonRecord({required final String pokemonName});
}
