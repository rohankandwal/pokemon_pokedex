import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/constants.dart';

class DBProvider {
  Box<PokemonDetailEntity>? _pokemonBox;

  DBProvider() {
    Hive.registerAdapter<PokemonDetailEntity>(PokemonDetailEntityAdapter());
    Hive.registerAdapter<PokemonDetailStatsEntity>(
        PokemonDetailStatsEntityAdapter());
    _initializeHiveBox();
  }

  Future _initializeHiveBox() async {
    _pokemonBox = await Hive.openBox(Constants.pokemonBox);
    return Future.value();
  }

  Future<bool> addPokemonToFavorite(
      {required final PokemonDetailEntity data}) async {
    if (_pokemonBox == null) {
      await _initializeHiveBox();
    }
    await _pokemonBox?.put(data.id, data);
    return Future.value(true);
  }

  Future<bool> checkPokemonFavorite({required final int id}) async {
    if (_pokemonBox == null) {
      await _initializeHiveBox();
    }
    return Future.value(_pokemonBox?.containsKey(id));
  }

  Future<bool> removePokemonFavorite({required final int id}) async {
    if (_pokemonBox == null) {
      await _initializeHiveBox();
    }
    _pokemonBox?.delete(id);
    return Future.value(true);
  }

  Future<Stream<List<PokemonDetailEntity>>>
      getAllFavoritePokemonsStream() async {
    if (_pokemonBox == null) {
      await _initializeHiveBox();
    }
    return Future.value(_pokemonBox!.watch().map((event) =>
        List<PokemonDetailEntity>.generate(_pokemonBox!.values.length,
            (index) => _pokemonBox!.getAt(index)!)));
  }

  Future<List<PokemonDetailEntity>> getAllFavoritePokemons() async {
    if (_pokemonBox == null) {
      await _initializeHiveBox();
    }
    return Future.value(_pokemonBox!.values.toList());
  }
}
