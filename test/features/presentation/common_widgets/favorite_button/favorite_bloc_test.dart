import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/usecase/add_pokemon_to_favorites_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/check_pokemon_favorite_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/remove_pokemon_favorite_usecase.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/favorite_button/favorite_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([
  AddPokemonToFavoritesUseCase,
  CheckPokemonFavoritesUseCase,
  RemovePokemonFavoritesUseCase,
])
main() {
  late FavoriteBloc favoriteBloc;
  late MockAddPokemonToFavoritesUseCase mockAddPokemonToFavoritesUseCase;
  late MockCheckPokemonFavoritesUseCase mockCheckPokemonFavoritesUseCase;
  late MockRemovePokemonFavoritesUseCase mockRemovePokemonFavoritesUseCase;

  setUp(() {
    mockAddPokemonToFavoritesUseCase = MockAddPokemonToFavoritesUseCase();
    mockCheckPokemonFavoritesUseCase = MockCheckPokemonFavoritesUseCase();
    mockRemovePokemonFavoritesUseCase = MockRemovePokemonFavoritesUseCase();

    favoriteBloc = FavoriteBloc(
      addPokemonToFavoritesUseCase: mockAddPokemonToFavoritesUseCase,
      checkPokemonFavoritesUseCase: mockCheckPokemonFavoritesUseCase,
      removePokemonFavoritesUseCase: mockRemovePokemonFavoritesUseCase,
    );
  });

  group('AddPokemonToFavoritesUseCase test', () {
    final pokemonDetailEntity = PokemonDetailEntity(
        id: 0,
        name: "name",
        type: "type",
        stats: List.empty(),
        height: 0,
        weight: 0);

    test('should get data from use case', () async {
      // arrange
      when(mockAddPokemonToFavoritesUseCase(any))
          .thenAnswer((_) async => const Right(true));
      // act
      favoriteBloc.add(AddFavoriteEvent(pokemonDetailEntity));
      await untilCalled(mockAddPokemonToFavoritesUseCase(any));
      // assert
      verify(mockAddPokemonToFavoritesUseCase(any));
    });

    test(
      'should emit [LoadedState] when getting data is success',
      () async {
        // arrange
        when(mockAddPokemonToFavoritesUseCase(any))
            .thenAnswer((_) async => const Right(true));
        // assert later
        expectLater(favoriteBloc.stream, emits(FavoriteLoadedState(true)));
        // act
        favoriteBloc.add(AddFavoriteEvent(pokemonDetailEntity));
      },
    );
  });

  group('CheckPokemonFavoritesUseCase test', () {
    int pokemonId = 0;

    test('should get data from use case', () async {
      // arrange
      when(mockCheckPokemonFavoritesUseCase(any))
          .thenAnswer((_) async => const Right(true));
      // act
      favoriteBloc.add(CheckFavoriteEvent(pokemonId));
      await untilCalled(mockCheckPokemonFavoritesUseCase(any));
      // assert
      verify(mockCheckPokemonFavoritesUseCase(any));
    });

    test(
      'should emit [LoadedState] when getting data is success',
      () async {
        // arrange
        when(mockCheckPokemonFavoritesUseCase(any))
            .thenAnswer((_) async => const Right(true));
        // assert later
        expectLater(favoriteBloc.stream, emits(FavoriteLoadedState(true)));
        // act
        favoriteBloc.add(CheckFavoriteEvent(pokemonId));
      },
    );
  });

  group('RemovePokemonFavoritesUseCase test', () {
    int pokemonId = 0;

    test('should get data from use case', () async {
      // arrange
      when(mockRemovePokemonFavoritesUseCase(any))
          .thenAnswer((_) async => const Right(true));
      // act
      favoriteBloc.add(RemoveFavoriteEvent(pokemonId));
      await untilCalled(mockRemovePokemonFavoritesUseCase(any));
      // assert
      verify(mockRemovePokemonFavoritesUseCase(any));
    });

    test(
      'should emit [LoadedState] when getting data is success',
      () async {
        // arrange
        when(mockRemovePokemonFavoritesUseCase(any))
            .thenAnswer((_) async => const Right(true));
        // assert later
        expectLater(favoriteBloc.stream, emits(FavoriteLoadedState(false)));
        // act
        favoriteBloc.add(RemoveFavoriteEvent(pokemonId));
      },
    );
  });
}
