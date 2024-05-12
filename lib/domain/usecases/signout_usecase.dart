import 'package:dartz/dartz.dart';
import 'package:resto/domain/repositories/auth_repository.dart';
import 'package:resto/shared/errors/failure.dart';

class SignOutUseCase {
  final AuthRepository repository;
  SignOutUseCase(this.repository);
  
  Future<Either<Failure, void>> call() async {
    return repository.logout();
  }
}
