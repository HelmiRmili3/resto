import 'dart:async';

import 'package:get/get.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/usecases/gerant/gerant_add_table_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_delete_table_use_case.dart';

import 'package:resto/domain/usecases/gerant/gerant_delete_user_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_get_orders_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_get_tabels_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_get_user_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_get_users_use_case.dart';
import 'package:resto/domain/usecases/gerant/gerant_order_payed_use_case.dart';

class GerantController extends GetxController {
  final GerantGetUsersUseCase gerantGetUsersUseCase;
  final GerantDeleteUserUseCase gerantDeleteUserUseCase;
  final GerantGetOrdersUseCase gerantGetOrdersUseCase;
  final GerantGetUserUseCase gerantGetUserUseCase;
  final GerantGetTabelsUseCase gerantGetTabelsUseCase;
  final GerantAddTableUserUseCase gerantAddTableUserUseCase;
  final GerantDeleteTableUseCase gerantDeleteTableUseCase;
  final GerantOrderPayedUseCase gerantOrderPayedUseCase;

  GerantController({
    required this.gerantGetUsersUseCase,
    required this.gerantDeleteUserUseCase,
    required this.gerantGetOrdersUseCase,
    required this.gerantGetUserUseCase,
    required this.gerantGetTabelsUseCase,
    required this.gerantAddTableUserUseCase,
    required this.gerantDeleteTableUseCase,
    required this.gerantOrderPayedUseCase,
  });

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;

  final _tabels = <TableModel>[].obs;
  List<TableModel> get tabels => _tabels;

  final _orders = <OrderModel>[].obs;
  List<OrderModel> get orders => _orders;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    fetchTabels();
    fetchOrders();
  }

  void fetchUsers() {
    gerantGetUsersUseCase().listen((List<UserModel> result) {
      _users.assignAll(result);
      print(result);
    });
  }

  void fetchTabels() {
    gerantGetTabelsUseCase().listen((List<TableModel> result) {
      _tabels.assignAll(result);
    });
  }

  void fetchOrders() {
    gerantGetOrdersUseCase().listen((List<OrderModel> result) {
      List<OrderModel> filteredOrders =
          result.where((order) => order.isReady && !order.isPayed).toList();

      _orders.assignAll(filteredOrders);
    });
  }

  Future<void> orderPayed(String orderId) async =>
      gerantOrderPayedUseCase(orderId);

  Future<void> deleteUser(String userId) async =>
      gerantDeleteUserUseCase(userId);

  Future<void> deleteTable(String tableId) async =>
      gerantDeleteTableUseCase(tableId);

  Future<void> addTable(int number, int places) async {
    TableModel table = TableModel(
      id: number.toString(),
      number: number,
      places: places,
      isReserved: false,
    );
    await gerantAddTableUserUseCase(table);
  }
}
