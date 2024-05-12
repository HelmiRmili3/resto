import 'package:get/get.dart';
import 'package:resto/data/respositories/signup_repository_impl.dart';

import 'package:resto/domain/usecases/get_user_usecase.dart';
import 'package:resto/presentation/controllers/signup_controller.dart';

import '../../data/datasources/remote_data_source.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<SignupRepositoryImpl>(
        () => SignupRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));
    Get.lazyPut(() => SignUpController(
          signUpUseCase: Get.find(),
        ));
  }
}
