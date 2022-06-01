import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_favorite_pokemons_stream_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_favorite_pokemons_usecase.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/favorite_pokemons/favorite_pokemons_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_pokemons_bloc_test.mocks.dart';

@GenerateMocks([
  GetAllFavoritePokemonsStreamUseCase,
  GetAllFavoritePokemonsListUseCase,
])
main() {
  late FavoritePokemonsBloc favoritePokemonsBloc;
  late MockGetAllFavoritePokemonsListUseCase
      mockGetAllFavoritePokemonsListUseCase;
  late MockGetAllFavoritePokemonsStreamUseCase
      mockGetAllFavoritePokemonsStreamUseCase;

  setUp(() {
    mockGetAllFavoritePokemonsStreamUseCase =
        MockGetAllFavoritePokemonsStreamUseCase();
    mockGetAllFavoritePokemonsListUseCase =
        MockGetAllFavoritePokemonsListUseCase();

    favoritePokemonsBloc = FavoritePokemonsBloc(
        getAllFavoritePokemonsStreamUseCase:
            mockGetAllFavoritePokemonsStreamUseCase,
        getAllFavoritePokemonsListUseCase:
            mockGetAllFavoritePokemonsListUseCase);
  });

  group('MockGetAllFavoritePokemonsListUseCase test', () {
    final pokemonDetailEntity = PokemonDetailEntity(
        id: 0,
        name: "name",
        type: "type",
        stats: List.empty(),
        height: 0,
        weight: 0);

    List<PokemonDetailEntity> noPokemons = List<PokemonDetailEntity>.empty();
    List<PokemonDetailEntity> pokemons = [pokemonDetailEntity];

    test('should get data from use case', () async {
      // arrange
      when(mockGetAllFavoritePokemonsListUseCase(any))
          .thenAnswer((_) async => Right(noPokemons));
      // act
      favoritePokemonsBloc.add(GetAllFavoritePokemonsEvent());
      await untilCalled(mockGetAllFavoritePokemonsListUseCase(any));
      // assert
      verify(mockGetAllFavoritePokemonsListUseCase(any));
    });

    test(
      'should emit [NoFavoritePokemonsState] when getting data is empty',
      () async {
        // arrange
        when(mockGetAllFavoritePokemonsListUseCase(any))
            .thenAnswer((_) async => Right(noPokemons));
        // assert later
        expectLater(
            favoritePokemonsBloc.stream, emits(NoFavoritePokemonsState()));
        // act
        favoritePokemonsBloc.add(GetAllFavoritePokemonsEvent());
      },
    );

    test(
      'should emit [FavoriteLoadingState, AllFavoritePokemonsFoundState] when getting data is empty',
      () async {
        // arrange
        when(mockGetAllFavoritePokemonsListUseCase(any))
            .thenAnswer((_) async => Right(pokemons));
        final expected = [
          FavoriteLoadingState(),
          AllFavoritePokemonsFoundState(pokemons)
        ];
        // assert later
        expectLater(favoritePokemonsBloc.stream, emitsInOrder(expected));
        // act
        favoritePokemonsBloc.add(GetAllFavoritePokemonsEvent());
      },
    );
  });

  group('MockGetAllFavoritePokemonsStreamUseCase test', () {
    const Stream<List<PokemonDetailEntity>> streams =
        Stream<List<PokemonDetailEntity>>.empty();

    test(
        'MockGetAllFavoritePokemonsStreamUseCase - should get data from use case',
        () async {
      // arrange
      when(mockGetAllFavoritePokemonsStreamUseCase(any))
          .thenAnswer((_) async => Right(streams));
      // act
      favoritePokemonsBloc.add(GetAllFavoritePokemonStreamEvent());
      await untilCalled(mockGetAllFavoritePokemonsStreamUseCase(any));
      // assert
      verify(mockGetAllFavoritePokemonsStreamUseCase(any));
    });
  });
}
