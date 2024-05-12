import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantGetUsersUseCase {
  final GerantRespository repository;

  GerantGetUsersUseCase(this.repository);

  Stream<List<UserModel>> call() {
    return repository.getUsers();
  }
}
