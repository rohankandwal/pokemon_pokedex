import 'package:byzat_pokemon/core/config/db_provider.dart';
import 'package:byzat_pokemon/core/config/my_shared_pref.dart';
import 'package:byzat_pokemon/core/network/network_info.dart';
import 'package:byzat_pokemon/features/data/client/client.dart';
import 'package:byzat_pokemon/features/data/datasource/local_datasource.dart';
import 'package:byzat_pokemon/features/data/datasource/remote_datasource.dart';
import 'package:byzat_pokemon/features/data/repositories/repository_impl.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:byzat_pokemon/features/domain/usecase/add_pokemon_to_favorites_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/check_pokemon_favorite_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_favorite_pokemons_stream_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_favorite_pokemons_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_pokemons_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/remove_pokemon_favorite_usecase.dart';
import 'package:byzat_pokemon/features/presentation/common_widgets/favorite_button/favorite_bloc.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/all_pokemons/all_pokemons_bloc.dart';
import 'package:byzat_pokemon/features/presentation/pages/home_screen/children/favorite_pokemons/favorite_pokemons_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AllPokemonsBloc(
        getAllPokemonsUseCase: sl(),
      ));
  sl.registerFactory(() => FavoriteBloc(
        addPokemonToFavoritesUseCase: sl(),
        checkPokemonFavoritesUseCase: sl(),
        removePokemonFavoritesUseCase: sl(),
      ));
  sl.registerFactory(() => FavoritePokemonsBloc(
      getAllFavoritePokemonsStreamUseCase: sl(),
      getAllFavoritePokemonsListUseCase: sl()));

  // usecases
  sl.registerLazySingleton(() => GetAllPokemonsUseCase(sl()));
  sl.registerLazySingleton(() => AddPokemonToFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => CheckPokemonFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => RemovePokemonFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => GetAllFavoritePokemonsStreamUseCase(sl()));
  sl.registerLazySingleton(() => GetAllFavoritePokemonsListUseCase(sl()));

  // repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  // No access to DB provider, job of LocalDataSource to choose which source
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(mySharedPref: sl(), dbProvider: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));

  // initializing dio
  final dio = Dio();
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      error: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    ));
  }

  // External
  final dbProvider = DBProvider();

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DBProvider>(() => dbProvider);
  sl.registerLazySingleton(() => RestClient(dio, sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
