import '../../data/models/order_model.dart';
import '../../data/models/table_model.dart';
import '../../data/models/user_model.dart';

abstract class GerantRespository {
  // Futures
  Future<void> deleteUser(String userId);
  Future<UserModel> getUser(String id);
  Future<void> addTable(TableModel table);
  Future<void> deleteTable(String tableId);
  Future<void> orderPayed(String orderId);

  //Streams
  Stream<List<OrderModel>> getOrders();
  Stream<List<TableModel>> getTabels();
  Stream<List<UserModel>> getUsers();
}
