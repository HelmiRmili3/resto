import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/data/models/transcation_model.dart';
import 'package:resto/data/models/user_model.dart';

import '../../domain/repositories/client_repository.dart';

class ClientRespositoryImpl implements ClientRespository {
  final RemoteDataSource remoteDataSource;

  ClientRespositoryImpl({required this.remoteDataSource});
  @override
  Stream<List<OrderModel>> getOrders() {
    return remoteDataSource.getOrders();
  }

  @override
  Stream<List<PlatModel>> getPlats() {
    return remoteDataSource.getMenu();
  }

  @override
  Future<UserModel> getUser(String id) {
    return remoteDataSource.getUser(id);
  }

  @override
  Future<void> addOrder(OrderModel order) {
    return remoteDataSource.addOrder(order);
  }

  @override
  Stream<List<TableModel>> getTabels() {
    return remoteDataSource.getTables();
  }

  @override
  Future<void> addReservation(String tableId) {
    return remoteDataSource.addReservation(tableId);
  }

  @override
  Stream<List<TransactionModel>> getTranscations() {
    return remoteDataSource.fetchTransactions();
  }
}
