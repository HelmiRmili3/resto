import 'package:resto/data/models/table_model.dart';
import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantAddTableUserUseCase {
  final GerantRespository repository;

  GerantAddTableUserUseCase(this.repository);

  Future<void> call(TableModel table) {
    return repository.addTable(table);
  }
}
