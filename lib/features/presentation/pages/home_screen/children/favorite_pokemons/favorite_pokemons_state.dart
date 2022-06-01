part of 'favorite_pokemons_bloc.dart';

abstract class FavoritePokemonsState extends Equatable {
  const FavoritePokemonsState();
}

class FavoritePokemonsInitial extends FavoritePokemonsState {
  @override
  List<Object> get props => [];
}

class NoFavoritePokemonsState extends FavoritePokemonsState {
  @override
  List<Object> get props => [];
}

class AllFavoritePokemonsFoundState extends FavoritePokemonsState {
  final List<PokemonDetailEntity> pokemons;

  const AllFavoritePokemonsFoundState(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}

class FavoriteLoadingState extends FavoritePokemonsState {
  @override
  List<Object?> get props => [];
}
