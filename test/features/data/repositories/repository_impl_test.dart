import 'package:byzat_pokemon/core/error/exceptions.dart';
import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/network/network_info.dart';
import 'package:byzat_pokemon/features/data/datasource/local_datasource.dart';
import 'package:byzat_pokemon/features/data/datasource/remote_datasource.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_detail_model.dart';
import 'package:byzat_pokemon/features/data/model/pokemon_list_model.dart';
import 'package:byzat_pokemon/features/data/repositories/repository_impl.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repository_impl_test.mocks.dart';

@GenerateMocks(
  [
    RepositoryImpl,
    NetworkInfoImpl,
    RemoteDataSource,
    LocalDataSource,
  ],
)
void main() {
  late MockRepositoryImpl mockRepositoryImpl;
  late MockNetworkInfoImpl mockNetworkInfo;
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late Repository repository;

  setUp(() {
    mockRepositoryImpl = MockRepositoryImpl();
    mockNetworkInfo = MockNetworkInfoImpl();
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();

    repository = RepositoryImpl(
        networkInfo: mockNetworkInfo,
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource);
  });

  group('getAllPokemons test', () {
    int offset = 0;
    String pokemonId = "Any";
    final pokemonDetailModel = PokemonDetailModel(
      0,
      pokemonId,
      [PokemonTypeObjectModel(PokemonTypeModel("Type"))],
      PokemonSpritesModel(
          PokemonSpritesOthersModel(PokemonOfficialArtworkModel(null))),
      List.empty(),
      0,
      0,
    );

    final pokemonListModel = PokemonListModel(List.empty(growable: true));
    pokemonListModel.results.add(PokemonListResultModel(pokemonId, "any"));

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockRemoteDataSource.getPokemonByNameOrId(idOrName: pokemonId))
          .thenAnswer((realInvocation) async => pokemonDetailModel);

      when(mockRemoteDataSource.getAllPokemons(offset: offset))
          .thenAnswer((realInvocation) async => pokemonListModel);

      // act
      repository.getAllPokemons(
        offset: offset,
      );
      // assert
      // checking if we are calling this function
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test(
          'should return remote data when the call to remote data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getPokemonByNameOrId(idOrName: pokemonId))
            .thenAnswer((realInvocation) async => pokemonDetailModel);

        when(mockRemoteDataSource.getAllPokemons(offset: offset))
            .thenAnswer((realInvocation) async => pokemonListModel);
        // act
        final Either<Failure, List<Future<PokemonDetailEntity>>> result =
            await repository.getAllPokemons(offset: offset);

        // assert
        // checking if we are calling this function
        verify(mockRemoteDataSource.getAllPokemons(offset: offset));
        // check if we are calling getPokemonByNameOrId to get pokemon details too
        verify(mockRemoteDataSource.getPokemonByNameOrId(idOrName: pokemonId));

        result.fold((l) => null, (r) async {
          for (var element in r) {
            final data = await element;
            expect(
                Right(data), equals(Right<Failure, PokemonDetailEntity>(data)));
          }
        });
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAllPokemons(offset: offset))
            .thenThrow(ServerException(message: 'any'));
        // act
        final result = await repository.getAllPokemons(offset: offset);
        // assert
        // checking if we are calling this function
        verify(mockRemoteDataSource.getAllPokemons(offset: offset));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure(message: "any"))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAllPokemons(offset: offset))
            .thenThrow(ServerException(message: 'any'));
        // act
        final result = await repository.getAllPokemons(offset: offset);
        // assert
        // We shouldn't be calling this function
        verifyZeroInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure(message: "any"))));
      });
    });
  });

  group('addPokemonToFavorite test', () {
    String pokemonId = "Any";

    final pokemonDetailEntity = PokemonDetailEntity(
        id: 0,
        name: pokemonId,
        type: "Type",
        stats: List.empty(),
        imageUrl: null,
        height: 0,
        weight: 0);

    test('checking we aren\'t looking for internet connection', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockLocalDataSource.addPokemonToFavorite(data: pokemonDetailEntity))
          .thenAnswer((realInvocation) async => true);

      // act
      repository.addPokemonToFavorite(
        data: pokemonDetailEntity,
      );
      // assert
      // No need to call for this function
      verifyNever(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should return remote data when the call to remote data source is success',
          () async {
        // arrange
        when(mockLocalDataSource.addPokemonToFavorite(
                data: pokemonDetailEntity))
            .thenAnswer((realInvocation) async => true);
        // act
        final result =
            await repository.addPokemonToFavorite(data: pokemonDetailEntity);

        // assert
        // checking if we are calling this function
        verify(mockLocalDataSource.addPokemonToFavorite(
            data: pokemonDetailEntity));

        result.fold((l) => null, (r) async {
          expect(result, const Right<Failure, bool>(true));
        });
      });
    });
  });

  group(
      'checkPokemonFavorite test - checking cases for pokemon exists in our favorite records',
      () {
    int pokemonId = 0;
    test('should return true if record exists', () async {
      // arrange
      when(mockLocalDataSource.checkPokemonFavorite(data: pokemonId))
          .thenAnswer((realInvocation) async => true);
      // act
      final result = await repository.checkPokemonFavorite(data: pokemonId);

      // assert
      // checking if we are calling this function
      verify(mockLocalDataSource.checkPokemonFavorite(data: pokemonId));

      result.fold((l) => null, (r) async {
        expect(result, const Right<Failure, bool>(true));
      });
    });

    test(
        'checkPokemonFavorite test - should return false if record doesn\'t exists',
        () async {
      // arrange
      when(mockLocalDataSource.checkPokemonFavorite(data: pokemonId))
          .thenAnswer((realInvocation) async => false);
      // act
      final result = await repository.checkPokemonFavorite(data: pokemonId);
      // assert
      // checking if we are calling this function
      verify(mockLocalDataSource.checkPokemonFavorite(data: pokemonId));
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(const Right<Failure, bool>(false)));
    });
  });

  group(
      'removePokemonFavorite test - checking cases for removing pokemon from our favorite records',
      () {
    int pokemonId = 0;
    test('should return true if record exists', () async {
      // arrange
      when(mockLocalDataSource.removePokemonFavorite(data: pokemonId))
          .thenAnswer((realInvocation) async => true);
      // act
      final result = await repository.removePokemonFavorite(data: pokemonId);

      // assert
      // checking if we are calling this function
      verify(mockLocalDataSource.removePokemonFavorite(data: pokemonId));

      result.fold((l) => null, (r) async {
        expect(result, const Right<Failure, bool>(true));
      });
    });

    test(
        'removePokemonFavorite test - should not throw error in case record is missing',
        () async {
      // arrange
      when(mockLocalDataSource.removePokemonFavorite(data: pokemonId))
          .thenAnswer((realInvocation) async => false);
      // act
      final result = await repository.removePokemonFavorite(data: pokemonId);
      // assert
      // checking if we are calling this function
      verify(mockLocalDataSource.removePokemonFavorite(data: pokemonId));
      verifyZeroInteractions(mockRemoteDataSource);
      result.fold((l) => null, (r) async {
        expect(result, const Right<Failure, bool>(false));
      });
    });
  });

  group('getAllFavoritePokemonsStream test', () {
    const Stream<List<PokemonDetailEntity>> futureStream =
        Stream<List<PokemonDetailEntity>>.empty();

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockLocalDataSource.getAllFavoritePokemonsStream())
          .thenAnswer((realInvocation) async => futureStream);

      // act
      repository.getAllFavoritePokemonsStream();
      // assert
      // checking if we are calling this function
      verifyNever(mockNetworkInfo.isConnected);
    });

    test('should return local data stream', () async {
      // arrange
      when(mockLocalDataSource.getAllFavoritePokemonsStream())
          .thenAnswer((realInvocation) async => futureStream);
      // act
      final response = await mockLocalDataSource.getAllFavoritePokemonsStream();

      // assert
      // checking if we are calling this function
      verify(mockLocalDataSource.getAllFavoritePokemonsStream());
      expect(response, futureStream);
    });
  });

  group('getAllFavoritePokemons test', () {
    List<PokemonDetailEntity> data = List<PokemonDetailEntity>.empty();

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockLocalDataSource.getAllFavoritePokemons())
          .thenAnswer((realInvocation) async => data);

      // act
      repository.getAllFavoritePokemons();
      // assert
      // checking if we are calling this function
      verifyNever(mockNetworkInfo.isConnected);
    });

    test('should return local data stream', () async {
      // arrange
      when(mockLocalDataSource.getAllFavoritePokemons())
          .thenAnswer((realInvocation) async => data);
      // act
      final response = await mockLocalDataSource.getAllFavoritePokemons();

      // assert
      // checking if we are calling this function
      verify(mockLocalDataSource.getAllFavoritePokemons());
      expect(response, data);
    });
  });
}
