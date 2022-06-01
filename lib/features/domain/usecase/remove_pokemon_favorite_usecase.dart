import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/usecase/usecase.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class RemovePokemonFavoritesUseCase
    extends UseCase<bool, RemoveFavoriteParams> {
  final Repository _repository;

  RemovePokemonFavoritesUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(RemoveFavoriteParams params) async {
    return await _repository.removePokemonFavorite(data: params.pokemonId);
  }
}

class RemoveFavoriteParams {
  final int pokemonId;

  RemoveFavoriteParams({
    required this.pokemonId,
  });
}
