part of 'favorite_pokemons_bloc.dart';

@immutable
abstract class FavoritePokemonsEvent extends Equatable {}

class GetAllFavoritePokemonsEvent extends FavoritePokemonsEvent {
  @override
  List<Object?> get props => [];
}

class GetAllFavoritePokemonStreamEvent extends FavoritePokemonsEvent {
  @override
  List<Object?> get props => [];
}

class NoFavoritePokemonsEvent extends FavoritePokemonsEvent {
  @override
  List<Object?> get props => [];
}

class AllFavoritePokemonsFoundEvent extends FavoritePokemonsEvent {
  final List<PokemonDetailEntity> pokemons;

  AllFavoritePokemonsFoundEvent(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}
