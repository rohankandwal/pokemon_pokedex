import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_pokemons_usecase.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/all_pokemons/all_pokemons_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'all_pokemons_bloc_test.mocks.dart';

@GenerateMocks([
  GetAllPokemonsUseCase,
])
void main() {
  late AllPokemonsBloc allPokemonsBloc;
  late MockGetAllPokemonsUseCase mockGetAllPokemonsUseCase;

  setUp(() {
    mockGetAllPokemonsUseCase = MockGetAllPokemonsUseCase();

    allPokemonsBloc =
        AllPokemonsBloc(getAllPokemonsUseCase: mockGetAllPokemonsUseCase);
  });

  group('MockGetAllPokemonsUseCase test', () {
    final pokemonDetailEntity = PokemonDetailEntity(
        id: 0,
        name: "name",
        type: "type",
        stats: List.empty(),
        height: 0,
        weight: 0);
    const int offset = 0;
    List<PokemonDetailEntity> pokemons = [pokemonDetailEntity];
    List<Future<PokemonDetailEntity>> futures = [
      Future.value(pokemonDetailEntity)
    ];

    test('should get data from use case', () async {
      // arrange
      when(mockGetAllPokemonsUseCase(any))
          .thenAnswer((_) async => Right(futures));
      // act
      allPokemonsBloc.add(GetAllPokemonListEvent(offset: offset));
      await untilCalled(mockGetAllPokemonsUseCase(any));
      // assert
      verify(mockGetAllPokemonsUseCase(any));
    });

    test(
      'should emit [AllPokemonsLoadingState, AllPokemonsLoadedState] in order when we get data',
      () async {
        // arrange
        when(mockGetAllPokemonsUseCase(any))
            .thenAnswer((_) async => Right(futures));

        final expected = [
          AllPokemonsLoadingState(),
          AllPokemonsLoadedState(pokemons: pokemons)
        ];

        // assert later
        expectLater(allPokemonsBloc.stream, emitsInOrder(expected));
        // act
        allPokemonsBloc.add(GetAllPokemonListEvent(offset: offset));
      },
    );

    test(
      'should emit [AllPokemonsLoadingState, AllPokemonsErrorState] when getting data is empty',
      () async {
        const String errorMessage = "any";
        // arrange
        when(mockGetAllPokemonsUseCase(any)).thenAnswer(
            (_) async => Left(ServerFailure(message: errorMessage)));

        final expected = [
          AllPokemonsLoadingState(),
          AllPokemonsErrorState(message: errorMessage)
        ];
        expectLater(allPokemonsBloc.stream, emitsInOrder(expected));
        // assert later

        // act
        allPokemonsBloc.add(GetAllPokemonListEvent(offset: offset));
      },
    );
  });
}
