import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantRespositoryImpl implements GerantRespository {
  final RemoteDataSource remoteDataSource;

  GerantRespositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<List<UserModel>> getUsers() {
    return remoteDataSource.getUsers();
  }

  @override
  Future<void> deleteUser(String userId) {
    return remoteDataSource.removeUser(userId);
  }

  @override
  Stream<List<OrderModel>> getOrders() {
    return remoteDataSource.getOrders();
  }

  @override
  Stream<List<TableModel>> getTabels() {
    return remoteDataSource.getTables();
  }

  @override
  Future<UserModel> getUser(String id) {
    return remoteDataSource.getUser(id);
  }

  @override
  Future<void> addTable(TableModel table) {
    return remoteDataSource.addTable(table);
  }

  @override
  Future<void> deleteTable(String tableId) {
    return remoteDataSource.removeTable(tableId);
  }

  @override
  Future<void> orderPayed(String orderId) {
    return remoteDataSource.orderPayed(orderId);
  }
}
