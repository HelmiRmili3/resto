import 'package:get/get.dart';

import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/respositories/client_repository_impl.dart';
import 'package:resto/domain/repositories/client_repository.dart';

import 'package:resto/domain/usecases/client/add_order_use_case.dart';
import 'package:resto/domain/usecases/client/add_reservation_use_case.dart';
import 'package:resto/domain/usecases/client/get_orders_use_case.dart';
import 'package:resto/domain/usecases/client/get_plats_use_case.dart';
import 'package:resto/domain/usecases/client/get_tables_use_case.dart';
import 'package:resto/domain/usecases/client/get_transactions_use_case.dart';
import 'package:resto/domain/usecases/get_user_usecase.dart';
import 'package:resto/presentation/controllers/client_controller.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl());
    Get.lazyPut<ClientRespository>(
        () => ClientRespositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => AddOrderUseCase(Get.find()));
    Get.lazyPut(() => GetTablesUseCase(Get.find()));
    Get.lazyPut(() => GetPlatsUseCase(Get.find()));
    Get.lazyPut(() => GetOrdersUseCase(Get.find()));
    Get.lazyPut(() => AddReservationUseCase(Get.find()));
    Get.lazyPut(() => GetUserUseCase(Get.find()));
    Get.lazyPut(() => GetTransactionsUseCase(Get.find()));

    Get.lazyPut(
      () => ClientController(
        addOrderUseCase: Get.find(),
        getTablesUseCase: Get.find(),
        getPlatsUseCase: Get.find(),
        getOrdersUseCase: Get.find(),
        addReservationUseCase: Get.find(),
        getUserUseCase: Get.find(),
        getTransactionsUseCase: Get.find(),
      ),
    );
  }
}
