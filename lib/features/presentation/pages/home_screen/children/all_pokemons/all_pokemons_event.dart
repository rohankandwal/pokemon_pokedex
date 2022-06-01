part of 'all_pokemons_bloc.dart';

@immutable
abstract class AllPokemonsEvent {}

class GetAllPokemonListEvent extends AllPokemonsEvent {
  final int offset;

  GetAllPokemonListEvent({required this.offset});
}

class AllPokemonLoadedErrorEvent extends AllPokemonsEvent {
  final String message;

  AllPokemonLoadedErrorEvent({required this.message});
}

class AllPokemonLoadedEvent extends AllPokemonsEvent {
  final List<PokemonDetailEntity> pokemons;

  AllPokemonLoadedEvent({required this.pokemons});
}
