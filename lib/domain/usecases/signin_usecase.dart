import 'package:dartz/dartz.dart';
import 'package:resto/domain/repositories/auth_repository.dart';
import 'package:resto/shared/errors/failure.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) async {
    return repository.signin(email, password);
  }
}
