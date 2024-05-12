import 'package:dartz/dartz.dart';
import 'package:resto/shared/errors/failure.dart';



abstract class SignupRepository {
  Future<Either<Failure, void>> signup(String email, String password);
}
