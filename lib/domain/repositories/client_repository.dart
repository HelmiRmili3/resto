import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/data/models/transcation_model.dart';
import 'package:resto/data/models/user_model.dart';

abstract class ClientRespository {
  Future<UserModel> getUser(String id);
  Future<void> addOrder(OrderModel order);
  Future<void> addReservation(String tableId);
  Stream<List<TransactionModel>> getTranscations();
  Stream<List<OrderModel>> getOrders();
  Stream<List<PlatModel>> getPlats();
  Stream<List<TableModel>> getTabels();
}
