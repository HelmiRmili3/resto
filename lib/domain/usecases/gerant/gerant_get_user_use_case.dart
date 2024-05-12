import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantGetUserUseCase {
  final GerantRespository repository;

  GerantGetUserUseCase(this.repository);

  Future<UserModel> call(String userId) {
    return repository.getUser(userId);
  }
}
