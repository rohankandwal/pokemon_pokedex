import 'package:byzat_pokemon/core/error/exceptions.dart';
import 'package:byzat_pokemon/features/data/datasource/remote_datasource.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_detail_model.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_datasource_test.mocks.dart';

@GenerateMocks(
  [
    RemoteDataSourceImpl,
  ],
)
void main() {
  late MockRemoteDataSourceImpl mockRemoteDataSourceImpl;

  setUp(() {
    mockRemoteDataSourceImpl = MockRemoteDataSourceImpl();
  });

  group('getAllPokemon API test', () {
    const int offset = 10;
    test(
      'should perform a POST request on the url /pokemon Endpoint',
      () async {
        final pokemonListModel = PokemonListModel(List.empty());
        when(mockRemoteDataSourceImpl.getAllPokemons(offset: offset))
            .thenAnswer((_) async => pokemonListModel);
        mockRemoteDataSourceImpl.getAllPokemons(offset: offset);

        verify(mockRemoteDataSourceImpl.getAllPokemons(offset: offset));
      },
    );

    test(
      'should return success response POST request on the url /pokemon Endpoint',
      () async {
        final pokemonListModel = PokemonListModel(List.empty());
        when(mockRemoteDataSourceImpl.getAllPokemons(offset: offset))
            .thenAnswer((_) async => pokemonListModel);
        final response =
            await mockRemoteDataSourceImpl.getAllPokemons(offset: offset);

        expect(response, pokemonListModel);
      },
    );

    test(
      'should throw ServerException response POST request on the url /pokemon Endpoint',
      () async {
        when(mockRemoteDataSourceImpl.getAllPokemons(offset: offset))
            .thenThrow(ServerException(message: "Some error"));

        expect(() => mockRemoteDataSourceImpl.getAllPokemons(offset: offset),
            throwsA(isA<Exception>()));
      },
    );
  });
  group('pokemon details API test', () {
    const String pokemonName = "any";
    final pokemonDetailModel = PokemonDetailModel(
      0,
      "any",
      List.empty(),
      PokemonSpritesModel(
          PokemonSpritesOthersModel(PokemonOfficialArtworkModel(null))),
      List.empty(),
      0,
      0,
    );
    test(
      'should perform a POST request on the url /pokemon/{nameOrId} Endpoint',
      () async {
        when(mockRemoteDataSourceImpl.getPokemonByNameOrId(
                idOrName: pokemonName))
            .thenAnswer((_) async => pokemonDetailModel);
        mockRemoteDataSourceImpl.getPokemonByNameOrId(idOrName: pokemonName);
        verify(mockRemoteDataSourceImpl.getPokemonByNameOrId(
            idOrName: pokemonName));
      },
    );

    test(
      'should return success response POST request on the url /pokemon/{nameOrId} Endpoint',
      () async {
        when(mockRemoteDataSourceImpl.getPokemonByNameOrId(
                idOrName: pokemonName))
            .thenAnswer((_) async => pokemonDetailModel);
        var response = await mockRemoteDataSourceImpl.getPokemonByNameOrId(
            idOrName: pokemonName);

        expect(response, pokemonDetailModel);
      },
    );

    test(
      'should throw ServerException response POST request on the url /pokemon/{nameOrId} Endpoint',
      () async {
        when(mockRemoteDataSourceImpl.getPokemonByNameOrId(
                idOrName: pokemonName))
            .thenThrow(ServerException(message: "Some error"));

        expect(
            () => mockRemoteDataSourceImpl.getPokemonByNameOrId(
                idOrName: pokemonName),
            throwsA(isA<Exception>()));
      },
    );
  });
}
