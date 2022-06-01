import 'package:byzat_pokemon/core/utils/constants.dart';

/// Exception from remote server in Data Layer
class ServerException implements Exception {
  String message;

  ServerException({this.message = Constants.unknownErrorOccurred});
}

/// CacheException from cache in Data Layer
class CacheException implements Exception {}
