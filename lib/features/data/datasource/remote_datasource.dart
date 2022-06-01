import 'package:byzat_pokemon/core/error/exceptions.dart';
import 'package:byzat_pokemon/core/utils/extension_function.dart';
import 'package:byzat_pokemon/features/data/client/client.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_detail_model.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_list_model.dart';
import 'package:dio/dio.dart';

/// Abstract class to get/push data from Remote Server
abstract class RemoteDataSource {
  /// Function used to fetch list of all the pokemons from server
  Future<PokemonListModel> getAllPokemons({required final int offset});

  Future<PokemonDetailModel> getPokemonByNameOrId(
      {required final String idOrName});
}

/// Implementation class to get/push data from Remote Server
class RemoteDataSourceImpl extends RemoteDataSource {
  final RestClient client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<PokemonListModel> getAllPokemons({required final int offset}) async {
    try {
      return await client.getAllPokemons(offset, 10);
    } on DioError catch (e) {
      throw ServerException(message: e.getErrorFromDio());
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<PokemonDetailModel> getPokemonByNameOrId(
      {required final String idOrName}) async {
    try {
      return await client.getPokemonByNameOrId(idOrName);
    } on DioError catch (e) {
      throw ServerException(message: e.getErrorFromDio());
    } on Exception {
      throw ServerException();
    }
  }
}
