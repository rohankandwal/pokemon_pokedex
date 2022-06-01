import 'package:byzat_pokemon/core/error/exceptions.dart';
import 'package:byzat_pokemon/features/data/datasource/local_datasource.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_datasource_test.mocks.dart';

@GenerateMocks(
  [
    LocalDataSourceImpl,
  ],
)
void main() {
  late MockLocalDataSourceImpl mockLocalDataSourceImpl;

  setUp(() {
    mockLocalDataSourceImpl = MockLocalDataSourceImpl();
  });

  group('getAllFavoritePokemonsStream function testing', () {
    const Stream<List<PokemonDetailEntity>> futureStream =
        Stream<List<PokemonDetailEntity>>.empty();
    test(
      'getAllFavoritePokemonsStream function is called',
      () async {
        when(mockLocalDataSourceImpl.getAllFavoritePokemonsStream())
            .thenAnswer((_) async => futureStream);
        mockLocalDataSourceImpl.getAllFavoritePokemonsStream();

        verify(mockLocalDataSourceImpl.getAllFavoritePokemonsStream());
      },
    );

    test(
      'when getAllFavoritePokemonsStream function is called, data is returned',
      () async {
        when(mockLocalDataSourceImpl.getAllFavoritePokemonsStream())
            .thenAnswer((_) async => futureStream);
        final response =
            await mockLocalDataSourceImpl.getAllFavoritePokemonsStream();

        expect(response, futureStream);
      },
    );

    test(
      'should throw CacheException response when getAllFavoritePokemonsStream function is called',
      () async {
        when(mockLocalDataSourceImpl.getAllFavoritePokemonsStream())
            .thenThrow(CacheException());

        expect(() => mockLocalDataSourceImpl.getAllFavoritePokemonsStream(),
            throwsA(isA<Exception>()));
      },
    );
  });

  group('getAllFavoritePokemon function testing', () {
    final Future<List<PokemonDetailEntity>> futureStream =
        Future<List<PokemonDetailEntity>>.value(List.empty());
    test(
      'getAllFavoritePokemons function is called',
      () async {
        when(mockLocalDataSourceImpl.getAllFavoritePokemons())
            .thenAnswer((_) async => futureStream);
        mockLocalDataSourceImpl.getAllFavoritePokemons();

        verify(mockLocalDataSourceImpl.getAllFavoritePokemons());
      },
    );

    test(
      'when getAllFavoritePokemons function is called, data is returned',
      () async {
        when(mockLocalDataSourceImpl.getAllFavoritePokemons())
            .thenAnswer((_) async => futureStream);
        final response = await mockLocalDataSourceImpl.getAllFavoritePokemons();

        expect(response, await futureStream);
      },
    );

    test(
      'should throw CacheException response when getAllFavoritePokemons function is called',
      () async {
        when(mockLocalDataSourceImpl.getAllFavoritePokemons())
            .thenThrow(CacheException());

        expect(() => mockLocalDataSourceImpl.getAllFavoritePokemons(),
            throwsA(isA<Exception>()));
      },
    );
  });

  group('addPokemonToFavorite function testing', () {
    final PokemonDetailEntity pokemonDetailEntity = PokemonDetailEntity(
        id: 0,
        name: "name",
        type: "type",
        stats: List.empty(),
        height: 0,
        weight: 0);
    test(
      'when addPokemonToFavorite function is called, return true',
      () async {
        when(mockLocalDataSourceImpl.addPokemonToFavorite(
                data: pokemonDetailEntity))
            .thenAnswer((_) async => true);
        mockLocalDataSourceImpl.addPokemonToFavorite(data: pokemonDetailEntity);

        verify(mockLocalDataSourceImpl.addPokemonToFavorite(
            data: pokemonDetailEntity));
      },
    );

    test(
      'when addPokemonToFavorite function is called, data is returned',
      () async {
        when(mockLocalDataSourceImpl.addPokemonToFavorite(
                data: pokemonDetailEntity))
            .thenAnswer((_) async => (true));
        final response = await mockLocalDataSourceImpl.addPokemonToFavorite(
            data: pokemonDetailEntity);

        expect(response, (true));
      },
    );

    test(
      'should throw CacheException response when addPokemonToFavorite function is called',
      () async {
        when(mockLocalDataSourceImpl.addPokemonToFavorite(
                data: pokemonDetailEntity))
            .thenThrow(CacheException());

        expect(
            () => mockLocalDataSourceImpl.addPokemonToFavorite(
                data: pokemonDetailEntity),
            throwsA(isA<Exception>()));
      },
    );
  });

  group('removePokemonFavorite function testing', () {
    test(
      'when removePokemonFavorite function is called, return true',
      () async {
        when(mockLocalDataSourceImpl.removePokemonFavorite(data: 0))
            .thenAnswer((_) async => true);
        mockLocalDataSourceImpl.removePokemonFavorite(data: 0);

        verify(mockLocalDataSourceImpl.removePokemonFavorite(data: 0));
      },
    );

    test(
      'when removePokemonFavorite function is called, data is returned',
      () async {
        when(mockLocalDataSourceImpl.removePokemonFavorite(data: 0))
            .thenAnswer((_) async => (true));
        final response =
            await mockLocalDataSourceImpl.removePokemonFavorite(data: 0);

        expect(response, (true));
      },
    );

    test(
      'should throw CacheException response when removePokemonFavorite function is called',
      () async {
        when(mockLocalDataSourceImpl.removePokemonFavorite(data: 0))
            .thenThrow(CacheException());

        expect(() => mockLocalDataSourceImpl.removePokemonFavorite(data: 0),
            throwsA(isA<Exception>()));
      },
    );
  });

  group('checkPokemonFavorite function testing', () {
    test(
      'when checkPokemonFavorite function is called, return true',
      () async {
        when(mockLocalDataSourceImpl.checkPokemonFavorite(data: 0))
            .thenAnswer((_) async => true);
        mockLocalDataSourceImpl.checkPokemonFavorite(data: 0);

        verify(mockLocalDataSourceImpl.checkPokemonFavorite(data: 0));
      },
    );

    test(
      'when checkPokemonFavorite function is called, data is returned',
      () async {
        when(mockLocalDataSourceImpl.checkPokemonFavorite(data: 0))
            .thenAnswer((_) async => (true));
        final response =
            await mockLocalDataSourceImpl.checkPokemonFavorite(data: 0);

        expect(response, (true));
      },
    );

    test(
      'should throw CacheException response when checkPokemonFavorite function is called',
      () async {
        when(mockLocalDataSourceImpl.checkPokemonFavorite(data: 0))
            .thenThrow(CacheException());

        expect(() => mockLocalDataSourceImpl.checkPokemonFavorite(data: 0),
            throwsA(isA<Exception>()));
      },
    );
  });
}
