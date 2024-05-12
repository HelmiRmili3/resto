import 'package:get/get.dart';
import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/respositories/auth_repository_impl.dart';
import 'package:resto/domain/repositories/auth_repository.dart';
import 'package:resto/domain/usecases/forget_password_usecase.dart';
import 'package:resto/domain/usecases/get_user_usecase.dart';
import 'package:resto/domain/usecases/signin_usecase.dart';
import 'package:resto/domain/usecases/signout_usecase.dart';
import 'package:resto/domain/usecases/signup_usecase.dart';
import 'package:resto/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());

    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => SignInUseCase(Get.find()));
    Get.lazyPut(() => SignUpUseCase(Get.find()));
    Get.lazyPut(() => SignOutUseCase(Get.find()));
    Get.lazyPut(() => ForgetPasswordUseCase(Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));

    Get.lazyPut(() => AuthController(
          signUpUseCase: Get.find(),
          signOutUseCase: Get.find(),
          forgetPasswordUseCase: Get.find(),
          signInUseCase: Get.find(),
          getUserUseCase: Get.find(),
        ));
  }
}
