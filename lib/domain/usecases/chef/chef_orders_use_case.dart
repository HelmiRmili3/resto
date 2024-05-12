import 'package:resto/domain/repositories/chef_repository.dart';

import '../../../data/models/order_model.dart';

class ChefGetOrdersUseCase {
  final ChefRespository repository;

  ChefGetOrdersUseCase(this.repository);

  Stream<List<OrderModel>> call() {
    return repository.getOrders();
  }
}
