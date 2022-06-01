import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/usecase/usecase.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class CheckPokemonFavoritesUseCase extends UseCase<bool, CheckFavoriteParams> {
  final Repository _repository;

  CheckPokemonFavoritesUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(CheckFavoriteParams params) async {
    return await _repository.checkPokemonFavorite(data: params.pokemonId);
  }
}

class CheckFavoriteParams {
  final int pokemonId;

  CheckFavoriteParams({
    required this.pokemonId,
  });
}
