import 'package:resto/domain/repositories/chef_repository.dart';

class ChefOrderReadyUseCase {
  final ChefRespository repository;

  ChefOrderReadyUseCase(this.repository);

  Future<void> call(String orderId) {
    return repository.orderReady(orderId);
  }
}
