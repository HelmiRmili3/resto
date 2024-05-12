import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase(this.repository);
  Future< UserModel> call(String id) async {
    return repository.getUser(id);
  }
}
