import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/signup_repository.dart';
import 'package:resto/shared/errors/failure.dart';
import 'package:resto/utils/enums.dart';

class SignupRepositoryImpl implements SignupRepository {
  final RemoteDataSource remoteDataSource;

  SignupRepositoryImpl({
    required this.remoteDataSource,
  });

  
  @override
  Future<Either<Failure, UserCredential?>> signup(
      String email, String password) async {
    try {
      final result = await remoteDataSource.signUpUser(email, password);
      if (result != null) {
        await remoteDataSource.addUser(UserModel(
            id: result.user!.uid,
            email: email,
            name: "client",
            role: Role.client,
            imageUrl: ""));
      }
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }
}
