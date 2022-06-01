import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/usecase/usecase.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class AddPokemonToFavoritesUseCase extends UseCase<bool, AddToFavoriteParams> {
  final Repository _repository;

  AddPokemonToFavoritesUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(AddToFavoriteParams params) async {
    return await _repository.addPokemonToFavorite(
        data: params.pokemonDetailEntity);
  }
}

class AddToFavoriteParams {
  final PokemonDetailEntity pokemonDetailEntity;

  AddToFavoriteParams({
    required this.pokemonDetailEntity,
  });
}
