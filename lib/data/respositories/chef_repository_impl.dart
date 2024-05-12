import 'package:resto/data/datasources/remote_data_source.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
import 'package:resto/data/models/user_model.dart';
import 'package:resto/domain/repositories/chef_repository.dart';

class ChefRespositoryImpl implements ChefRespository {
  final RemoteDataSource remoteDataSource;

  ChefRespositoryImpl({required this.remoteDataSource});
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
  Future<void> addPlat(PlatModel plat) {
    return remoteDataSource.addPlate(plat);
  }

  @override
  Future<void> orderReady(String orderId) {
    return remoteDataSource.orderReady(orderId);
  }

  @override
  Future<void> deletePlat(String platId) {
    return remoteDataSource.removePlate(platId);
  }
}
