import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/data/models/user_model.dart';

abstract class ChefRespository {
  Future<UserModel> getUser(String id);
  Stream<List<OrderModel>> getOrders();
  Stream<List<PlatModel>> getPlats();
  Future<void> addPlat(PlatModel plat);
  Future<void> deletePlat(String platId);

  Future<void> orderReady(String orderId);
}
