import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantOrderPayedUseCase {
  final GerantRespository repository;

  GerantOrderPayedUseCase(this.repository);

  Future<void> call(String orderId) {
    return repository.orderPayed(orderId);
  }
}
