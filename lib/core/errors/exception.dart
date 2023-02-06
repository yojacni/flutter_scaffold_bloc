class ServerException implements Exception {
  ServerException({required this.message});
  final String message;
}

class CacheException implements Exception {}

class NotFoundException implements Exception {}

class EntityNotFoundException implements Exception {
  EntityNotFoundException({required this.message});

  final String message;
}

class UnauthorizedException implements Exception {}
