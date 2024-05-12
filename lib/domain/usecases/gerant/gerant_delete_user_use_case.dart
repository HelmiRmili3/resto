import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantDeleteUserUseCase {
  final GerantRespository repository;

  GerantDeleteUserUseCase(this.repository);

  Future<void> call(String userId) {
    return repository.deleteUser(userId);
  }
}
