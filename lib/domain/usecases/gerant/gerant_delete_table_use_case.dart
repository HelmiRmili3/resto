import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantDeleteTableUseCase {
  final GerantRespository repository;

  GerantDeleteTableUseCase(this.repository);

  Future<void> call(String tableId) {
    return repository.deleteTable(tableId);
  }
}
