import 'package:byzat_pokemon/core/config/db_provider.dart';
import 'package:byzat_pokemon/core/config/my_shared_pref.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';

/// Abstract class for saving/loading data from local storage
abstract class LocalDataSource {
  /// Function to save new pokemon into database
  Future<bool> addPokemonToFavorite({required final PokemonDetailEntity data});

  /// Function to check if a pokemon is favorite or not
  Future<bool> checkPokemonFavorite({required int data});

  /// Function to check if a pokemon is favorite or not
  Future<bool> removePokemonFavorite({required int data});

  /// Function to get stream of all the favorite pokemons
  Future<Stream<List<PokemonDetailEntity>>> getAllFavoritePokemonsStream();

  /// Function to get all the favorite pokemons
  Future<List<PokemonDetailEntity>> getAllFavoritePokemons();
}

/// Implementation class used for saving/loading data from Local storage
class LocalDataSourceImpl extends LocalDataSource {
  final MySharedPref mySharedPref;
  final DBProvider dbProvider;

  LocalDataSourceImpl({
    required this.mySharedPref,
    required this.dbProvider,
  });

  @override
  Future<bool> addPokemonToFavorite({required final PokemonDetailEntity data}) {
    return dbProvider.addPokemonToFavorite(data: data);
  }

  @override
  Future<bool> checkPokemonFavorite({required final int data}) {
    return dbProvider.checkPokemonFavorite(id: data);
  }

  @override
  Future<bool> removePokemonFavorite({required final int data}) {
    return dbProvider.removePokemonFavorite(id: data);
  }

  @override
  Future<Stream<List<PokemonDetailEntity>>>
      getAllFavoritePokemonsStream() async {
    return await dbProvider.getAllFavoritePokemonsStream();
  }

  @override
  Future<List<PokemonDetailEntity>> getAllFavoritePokemons() {
    return dbProvider.getAllFavoritePokemons();
  }
}
