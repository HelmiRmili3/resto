import 'package:resto/data/models/order_model.dart';
import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantGetOrdersUseCase {
  final GerantRespository repository;

  GerantGetOrdersUseCase(this.repository);

  Stream<List<OrderModel>> call() {
    return repository.getOrders();
  }
}
