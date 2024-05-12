import 'package:resto/data/models/order_model.dart';
import 'package:resto/domain/repositories/client_repository.dart';

class AddOrderUseCase {
  final ClientRespository repository;

  AddOrderUseCase(this.repository);

  Future<void> call(OrderModel order) {
    return repository.addOrder(order);
  }
}
