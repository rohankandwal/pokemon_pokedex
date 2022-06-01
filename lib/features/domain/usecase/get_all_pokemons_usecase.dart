import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/usecase/usecase.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPokemonsUseCase
    extends UseCase<List<Future<PokemonDetailEntity>>, GetAllPokemonsParams> {
  final Repository _repository;

  GetAllPokemonsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Future<PokemonDetailEntity>>>> call(
      GetAllPokemonsParams params) async {
    return await _repository.getAllPokemons(offset: params.offset);
  }
}

class GetAllPokemonsParams {
  final int offset;

  GetAllPokemonsParams({
    required this.offset,
  });
}
