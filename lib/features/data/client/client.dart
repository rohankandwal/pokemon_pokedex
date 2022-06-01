import 'package:byzat_pokemon/core/config/my_shared_pref.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_detail_model.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_list_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// Remote client for interacting with remote server
@RestApi(baseUrl: "https://pokeapi.co/api/v2/")
abstract class RestClient {
  /// flutter pub run build_runner build --delete-conflicting-outputs
  factory RestClient(final Dio dio, final MySharedPref sharedPref) {
    return _RestClient(dio);
  }

  @GET("pokemon")
  Future<PokemonListModel> getAllPokemons(
    @Query("offset") final int offset,
    @Query("limit") final int limit,
  );

  @GET("pokemon/{nameOrId}")
  Future<PokemonDetailModel> getPokemonByNameOrId(
      @Path("nameOrId") String nameOrId);
}
