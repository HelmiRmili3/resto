import 'package:dartz/dartz.dart';
import 'package:resto/data/models/user_model.dart';

import '../../shared/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signup(String email, String password);
  Future<Either<Failure, void>> signin(String email, String password);
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<UserModel> getUser(String id);
  Future<Either<Failure, void>> logout();
}
