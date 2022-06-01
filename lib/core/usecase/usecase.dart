import 'package:dartz/dartz.dart';

import '../error/failures.dart';

/// Base class for UseCases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Class used when no parameter needs to be passed
class NoParams {}
