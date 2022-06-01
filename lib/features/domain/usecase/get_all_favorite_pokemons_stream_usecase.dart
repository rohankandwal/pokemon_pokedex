import 'package:byzat_pokemon/core/error/failures.dart';
import 'package:byzat_pokemon/core/usecase/usecase.dart';
import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_entity.dart';
import 'package:byzat_pokemon/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class GetAllFavoritePokemonsStreamUseCase
    extends UseCase<Stream<List<PokemonDetailEntity>>, NoParams> {
  final Repository _repository;

  GetAllFavoritePokemonsStreamUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<PokemonDetailEntity>>>> call(
      NoParams params) async {
    return await _repository.getAllFavoritePokemonsStream();
  }
}
