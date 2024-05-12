import 'package:get/get.dart';
import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/domain/usecases/gerant/gerant_add_table_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_delete_table_use_case.dart';

import 'package:resto/domain/usecases/gerant/gerant_delete_user_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_get_users_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_order_payed_use_case.dart';
import 'package:resto/presentation/controllers/gerant_controller.dart';

import '../../data/respositories/gerant_repository_impl.dart';
import '../../domain/repositories/gerant_repository.dart';

import '../../domain/usecases/gerant/gerant_get_orders_use_case.dart';
import '../../domain/usecases/gerant/gerant_get_tabels_use_case.dart';
import '../../domain/usecases/gerant/gerant_get_user_use_case.dart';

class GerantBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());

    Get.lazyPut<GerantRespository>(
        () => GerantRespositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => GerantGetUsersUseCase(Get.find()));
    Get.lazyPut(() => GerantDeleteUserUseCase(Get.find()));
    Get.lazyPut(() => GerantGetOrdersUseCase(Get.find()));
    Get.lazyPut(() => GerantGetUserUseCase(Get.find()));
    Get.lazyPut(() => GerantGetTabelsUseCase(Get.find()));
    Get.lazyPut(() => GerantAddTableUserUseCase(Get.find()));
    Get.lazyPut(() => GerantDeleteTableUseCase(Get.find()));
    Get.lazyPut(() => GerantOrderPayedUseCase(Get.find()));

    Get.lazyPut(() => GerantController(
          gerantGetUsersUseCase: Get.find(),
          gerantDeleteUserUseCase: Get.find(),
          gerantGetOrdersUseCase: Get.find(),
          gerantGetUserUseCase: Get.find(),
          gerantGetTabelsUseCase: Get.find(),
          gerantAddTableUserUseCase: Get.find(),
          gerantDeleteTableUseCase: Get.find(),
          gerantOrderPayedUseCase: Get.find(),
        ));
  }
}
