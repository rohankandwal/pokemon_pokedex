import 'package:bloc/bloc.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/usecase/add_pokemon_to_favorites_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/check_pokemon_favorite_usecase.dart';
import 'package:byzat_pokemon/features/domain/usecase/remove_pokemon_favorite_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final AddPokemonToFavoritesUseCase addPokemonToFavoritesUseCase;
  final CheckPokemonFavoritesUseCase checkPokemonFavoritesUseCase;
  final RemovePokemonFavoritesUseCase removePokemonFavoritesUseCase;

  FavoriteBloc({
    required this.addPokemonToFavoritesUseCase,
    required this.checkPokemonFavoritesUseCase,
    required this.removePokemonFavoritesUseCase,
  }) : super(FavoriteInitial()) {
    on<AddFavoriteEvent>(_addToFavorite);
    on<FavoriteStateChangedEvent>(_favoriteStateChanged);
    on<CheckFavoriteEvent>(_checkFavoriteEvent);
    on<RemoveFavoriteEvent>(_removeFavoriteEvent);
  }

  _addToFavorite(final AddFavoriteEvent event, final Emitter emitter) async {
    final result = await addPokemonToFavoritesUseCase
        .call(AddToFavoriteParams(pokemonDetailEntity: event.pokemon));
    result.fold(
        (failure) => null, (data) => add(FavoriteStateChangedEvent(data)));
  }

  _favoriteStateChanged(
      final FavoriteStateChangedEvent event, final Emitter emitter) {
    emitter(FavoriteLoadedState(event.isFavorite));
  }

  _checkFavoriteEvent(
      final CheckFavoriteEvent event, final Emitter emitter) async {
    final result = await checkPokemonFavoritesUseCase(
        CheckFavoriteParams(pokemonId: event.id));
    result.fold((l) => null, (data) => add(FavoriteStateChangedEvent(data)));
  }

  _removeFavoriteEvent(
      final RemoveFavoriteEvent event, final Emitter emitter) async {
    final result = await removePokemonFavoritesUseCase(
        RemoveFavoriteParams(pokemonId: event.id));
    result.fold((l) => null, (data) => add(FavoriteStateChangedEvent(!data)));
  }
}
