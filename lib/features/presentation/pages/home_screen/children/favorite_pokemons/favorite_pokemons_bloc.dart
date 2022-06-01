import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:byzat_pokemon/core/usecase/usecase.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_favorite_pokemons_stream_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_favorite_pokemons_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'favorite_pokemons_event.dart';
part 'favorite_pokemons_state.dart';

class FavoritePokemonsBloc
    extends Bloc<FavoritePokemonsEvent, FavoritePokemonsState> {
  final GetAllFavoritePokemonsStreamUseCase getAllFavoritePokemonsStreamUseCase;
  final GetAllFavoritePokemonsListUseCase getAllFavoritePokemonsListUseCase;

  StreamSubscription<List<PokemonDetailEntity>>? _feedSubscription;

  FavoritePokemonsBloc({
    required this.getAllFavoritePokemonsStreamUseCase,
    required this.getAllFavoritePokemonsListUseCase,
  }) : super(FavoritePokemonsInitial()) {
    on<GetAllFavoritePokemonsEvent>(_getAllFavoritePokemons);
    on<GetAllFavoritePokemonStreamEvent>(_getAllFavoritePokemonStream);
    on<NoFavoritePokemonsEvent>(_noFavoritePokemons);
    on<AllFavoritePokemonsFoundEvent>(_allFavoritePokemonsFound);
  }

  _getAllFavoritePokemonStream(final GetAllFavoritePokemonStreamEvent event,
      final Emitter emitter) async {
    _feedSubscription?.cancel();
    getAllFavoritePokemonsStreamUseCase(NoParams()).then((event) => event.fold(
        (l) => add(NoFavoritePokemonsEvent()),
        (r) => _feedSubscription = r.listen(
              (data) {
                if (data.isNotEmpty) {
                  add(AllFavoritePokemonsFoundEvent(data));
                } else {
                  add(NoFavoritePokemonsEvent());
                }
              },
            )));
  }

  _getAllFavoritePokemons(
      final GetAllFavoritePokemonsEvent event, final Emitter emitter) async {
    /// Hive doesn't give initial data with streams,
    /// so we need to fetch it manually the first time
    getAllFavoritePokemonsListUseCase(NoParams()).then(
        (value) => value.fold((l) => add(NoFavoritePokemonsEvent()), (data) {
              if (data.isNotEmpty) {
                add(AllFavoritePokemonsFoundEvent(data));
              } else {
                add(NoFavoritePokemonsEvent());
              }
            }));
  }

  _noFavoritePokemons(
      final NoFavoritePokemonsEvent event, final Emitter emitter) {
    emitter(NoFavoritePokemonsState());
  }

  _allFavoritePokemonsFound(
      final AllFavoritePokemonsFoundEvent event, final Emitter emitter) {
    emitter(FavoriteLoadingState());
    emitter(AllFavoritePokemonsFoundState(event.pokemons));
  }

  @override
  Future<void> close() {
    _feedSubscription?.cancel();
    return super.close();
  }
}
