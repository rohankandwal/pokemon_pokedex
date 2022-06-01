part of 'all_pokemons_bloc.dart';

@immutable
abstract class AllPokemonsState extends Equatable {}

class AllPokemonsInitial extends AllPokemonsState {
  @override
  List<Object?> get props => [];
}

class AllPokemonsLoadingState extends AllPokemonsState {
  @override
  List<Object?> get props => [];
}

class AllPokemonsLoadedState extends AllPokemonsState {
  final List<PokemonDetailEntity> pokemons;

  AllPokemonsLoadedState({
    required this.pokemons,
  });

  @override
  List<Object?> get props => [pokemons];
}

class AllPokemonsErrorState extends AllPokemonsState {
  final String message;

  AllPokemonsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
