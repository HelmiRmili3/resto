import 'package:get/get.dart';
import 'package:resto/data/respositories/chef_repository_impl.dart';
import 'package:resto/domain/repositories/chef_repository.dart';
import 'package:resto/domain/usecases/chef/chef_add_plat_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_delete_plate_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_order_ready_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_orders_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_plats_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_user_use_case.dart';
import 'package:resto/presentation/controllers/chef_controller.dart';

import '../../data/datasources/remote_data_source.dart';

class ChefBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());

    Get.lazyPut<ChefRespository>(
        () => ChefRespositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => ChefGetOrdersUseCase(Get.find()));
    Get.lazyPut(() => ChefGetPlatssUseCase(Get.find()));
    Get.lazyPut(() => ChefGetUserUseCase(Get.find()));
    Get.lazyPut(() => ChefAddPlatUseCase(Get.find()));
    Get.lazyPut(() => ChefOrderReadyUseCase(Get.find()));
    Get.lazyPut(() => ChefDeletePlatUseCase(Get.find()));

    Get.lazyPut(() => ChefController(
          chefGetOrdersUseCase: Get.find(),
          chefGetPlatssUseCase: Get.find(),
          chefGetUserUseCase: Get.find(),
          chefAddPlatUseCase: Get.find(),
          chefOrderReadyUseCase: Get.find(),
          chefDeletePlatUseCase: Get.find(),
        ));
  }
}
