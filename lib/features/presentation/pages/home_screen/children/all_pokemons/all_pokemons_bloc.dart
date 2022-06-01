import 'package:bloc/bloc.dart';
import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/utils/constants.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/usecase/get_all_pokemons_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'all_pokemons_event.dart';
part 'all_pokemons_state.dart';

class AllPokemonsBloc extends Bloc<AllPokemonsEvent, AllPokemonsState> {
  final GetAllPokemonsUseCase getAllPokemonsUseCase;

  AllPokemonsBloc({required this.getAllPokemonsUseCase})
      : super(AllPokemonsInitial()) {
    on<GetAllPokemonListEvent>(_getAllPokemonEvent);
    on<AllPokemonLoadedErrorEvent>(_getAllPokemonErrorEvent);
    on<AllPokemonLoadedEvent>(_getAllPokemonLoadedEvent);
  }

  _getAllPokemonEvent(
      final GetAllPokemonListEvent event, final Emitter emitter) async {
    emitter(AllPokemonsLoadingState());
    final result = await getAllPokemonsUseCase
        .call(GetAllPokemonsParams(offset: event.offset));
    result.fold((failure) async {
      if (failure is CacheFailure) {
        add(AllPokemonLoadedErrorEvent(message: failure.message));
      } else if (failure is ServerFailure) {
        add(AllPokemonLoadedErrorEvent(
          message: failure.message,
        ));
      } else {
        add(AllPokemonLoadedErrorEvent(
            message: Constants.unknownErrorOccurred));
      }
    }, (Iterable<Future<PokemonDetailEntity>> loadedDataEntity) async {
      add(AllPokemonLoadedEvent(pokemons: await Future.wait(loadedDataEntity)));
    });
  }

  _getAllPokemonErrorEvent(
      final AllPokemonLoadedErrorEvent event, final Emitter emitter) {
    emitter(AllPokemonsErrorState(message: event.message));
  }

  _getAllPokemonLoadedEvent(
      final AllPokemonLoadedEvent event, final Emitter emitter) {
    emitter(AllPokemonsLoadedState(pokemons: event.pokemons));
  }
}
