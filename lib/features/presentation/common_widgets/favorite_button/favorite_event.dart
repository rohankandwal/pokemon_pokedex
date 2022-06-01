part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class CheckFavoriteEvent extends FavoriteEvent {
  final int id;

  CheckFavoriteEvent(this.id);
}

class AddFavoriteEvent extends FavoriteEvent {
  final PokemonDetailEntity pokemon;

  AddFavoriteEvent(this.pokemon);
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final int id;

  RemoveFavoriteEvent(this.id);
}

class FavoriteStateChangedEvent extends FavoriteEvent {
  final bool isFavorite;

  FavoriteStateChangedEvent(this.isFavorite);
}
