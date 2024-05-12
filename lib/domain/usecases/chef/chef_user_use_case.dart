import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/chef_repository.dart';

class ChefGetUserUseCase {
  final ChefRespository repository;

  ChefGetUserUseCase(this.repository);

  Future<UserModel> call(String userId) {
    return repository.getUser(userId);
  }
}
