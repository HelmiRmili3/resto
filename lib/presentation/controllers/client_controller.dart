import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
// import 'package:resto/data/models/reservation_model.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/data/models/transcation_model.dart';
import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/usecases/client/add_order_use_case.dart';
import 'package:resto/domain/usecases/client/add_reservation_use_case.dart';
import 'package:resto/domain/usecases/client/get_orders_use_case.dart';
import 'package:resto/domain/usecases/client/get_plats_use_case.dart';
import 'package:resto/domain/usecases/client/get_transactions_use_case.dart';
import 'package:resto/domain/usecases/get_user_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../domain/usecases/client/get_tables_use_case.dart';

class ClientController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final AddOrderUseCase addOrderUseCase;
  final GetTablesUseCase getTablesUseCase;
  final GetPlatsUseCase getPlatsUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final AddReservationUseCase addReservationUseCase;
  final GetUserUseCase getUserUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;

  ClientController({
    required this.getPlatsUseCase,
    required this.addOrderUseCase,
    required this.getTablesUseCase,
    required this.getOrdersUseCase,
    required this.addReservationUseCase,
    required this.getUserUseCase,
    required this.getTransactionsUseCase,
  });
  QRViewController? qrcontroller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  RxInt currentIndex = 0.obs;

  final _transcations = <TransactionModel>[].obs;
  List<TransactionModel> get transactions => _transcations;

  final _orders = <OrderModel>[].obs;
  List<OrderModel> get orders => _orders;

  final _tabels = <TableModel>[].obs;
  List<TableModel> get tabels => _tabels;

  final _plats = <PlatModel>[].obs;
  List<PlatModel> get plats => _plats;

  List<PlatModel> selectedPlats = [];
  RxInt selectedTable = RxInt(-1);

  Rx<User?> user = Rx<User?>(null);
  Rx<UserModel?> data = Rx<UserModel?>(null);

  double calculateTotalPrice(List<PlatModel> plats) {
    double totalPrice = 0.0;
    for (var plat in plats) {
      totalPrice += plat.prix;
    }
    return totalPrice;
  }

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
      if (user.value != null) {
        getUserUseCase.repository.getUser(user.value!.uid).then((userModel) {
          data.value = userModel;
        });
        orders.clear();
        transactions.clear();
      }
    });
    fetchTranscations();
    fetchOrders();
    fetchTables();
    fetchPlats();
    update();
  }

  void fetchTranscations() {
    getTransactionsUseCase().listen((List<TransactionModel> result) {
      List<TransactionModel> filteredTranscations = result
          .where((transaction) => transaction.orderedBy == user.value!.uid)
          .toList();
      _transcations.assignAll(filteredTranscations);
    });
    update();
  }

  void fetchOrders() {
    getOrdersUseCase().listen((List<OrderModel> result) {
      List<OrderModel> filteredOrders =
          result.where((order) => order.orderedBy == user.value!.uid).toList();
      _orders.assignAll(filteredOrders);
    });
    update();
  }

  void fetchTables() {
    getTablesUseCase().listen((List<TableModel> result) {
      _tabels.assignAll(result);
    });
    update();
  }

  void fetchPlats() {
    getPlatsUseCase().listen((List<PlatModel> result) {
      _plats.assignAll(result);
    });
    update();
  }

  Future<void> addOrder() async {
    if (selectedPlats.isNotEmpty && selectedTable.value != -1) {
      OrderModel order = OrderModel(
        id: const Uuid().v1(),
        order: selectedPlats,
        prix: calculateTotalPrice(selectedPlats),
        orderedBy: user.value!.uid,
        reservationId: selectedTable.value,
        table: selectedTable.value.toString(),
        isReady: false,
        isPayed: false,
      );
      await addReservationUseCase(selectedTable.value.toString());
      await addOrderUseCase(order);
      selectedPlats.clear();
      selectedTable.value = -1;
      print('Order added successfully');
      update();
    } else {
      Get.snackbar(
        "Error",
        "You have to add plats and table",
        backgroundColor: Colors.red,
      );
    }
  }

  bool isPlateSelected(PlatModel plate) {
    return selectedPlats.any((selected) => selected == plate);
  }

  void addPlate(PlatModel plat) {
    selectedPlats.add(plat);
  }

  void removePlate(PlatModel plate) {
    selectedPlats.removeWhere((plat) => plat == plate);
  }

  void setSelectedTable(int tableNumber) {
    selectedTable.value = tableNumber;
  }

  void swipeRight() {
    currentIndex.value = (currentIndex.value - 1).clamp(0, 1);
  }

  void swipeLeft() {
    currentIndex.value = (currentIndex.value + 1).clamp(0, 1);
  }

  @override
  void onClose() {
    orders.clear();
    transactions.clear();
    super.onClose();
  }
}
