import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/auth_repository.dart';
import 'package:resto/shared/errors/failure.dart';
import 'package:resto/utils/enums.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      final result = await remoteDataSource.forgetPassword(email);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await remoteDataSource.logoutUser();
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signin(
      String email, String password) async {
    try {
      final result = await remoteDataSource.signInUser(email, password);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

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
  
  @override
  Future<UserModel> getUser(String id) async {
   return await remoteDataSource.getUser(id);
  }
}
