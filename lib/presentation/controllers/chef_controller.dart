import 'package:get/get.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/domain/usecases/chef/chef_add_plat_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_delete_plate_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_order_ready_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_orders_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_plats_use_case.dart';
import 'package:resto/domain/usecases/chef/chef_user_use_case.dart';
import 'package:uuid/uuid.dart';

class ChefController extends GetxController {
  final ChefGetOrdersUseCase chefGetOrdersUseCase;
  final ChefGetPlatssUseCase chefGetPlatssUseCase;
  final ChefGetUserUseCase chefGetUserUseCase;
  final ChefAddPlatUseCase chefAddPlatUseCase;
  final ChefOrderReadyUseCase chefOrderReadyUseCase;
  final ChefDeletePlatUseCase chefDeletePlatUseCase;
  final _orders = <OrderModel>[].obs;
  List<OrderModel> get orders => _orders;

  final _plats = <PlatModel>[].obs;
  List<PlatModel> get plats => _plats;

  ChefController({
    required this.chefGetOrdersUseCase,
    required this.chefGetPlatssUseCase,
    required this.chefGetUserUseCase,
    required this.chefAddPlatUseCase,
    required this.chefOrderReadyUseCase,
    required this.chefDeletePlatUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchPlats();
    fetchOrders();
  }

  void fetchOrders() {
    chefGetOrdersUseCase().listen((List<OrderModel> result) {
      // Filter orders that are not ready
      List<OrderModel> filteredOrders =
          result.where((order) => !order.isReady).toList();

      _orders.assignAll(filteredOrders);
      print(filteredOrders);
    });
  }

  void fetchPlats() {
    chefGetPlatssUseCase().listen((List<PlatModel> result) {
      _plats.assignAll(result);
      print(result);
    });
  }

  Future<void> addPate(
    String name,
    double prix,
    String imageUrl,
    String description,
  ) async {
    PlatModel plat = PlatModel(
        id: const Uuid().v1(),
        name: name,
        prix: prix,
        imageUrl: imageUrl,
        description: description,
        ingredients: []);
    await chefAddPlatUseCase(plat);
  }

  Future<void> orderReady(String orderId) async {
    await chefOrderReadyUseCase(orderId);
  }

  Future<void> deletePlate(String plateId) async {
    await chefDeletePlatUseCase(plateId);
  }
}
