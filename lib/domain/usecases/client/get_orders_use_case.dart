import 'package:resto/data/models/order_model.dart';
import 'package:resto/domain/repositories/client_repository.dart';

class GetOrdersUseCase {
  final ClientRespository repository;

  GetOrdersUseCase(this.repository);

  Stream<List<OrderModel>> call() {
    return repository.getOrders();
  }
}
