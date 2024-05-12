import 'package:resto/data/models/table_model.dart';
import 'package:resto/domain/repositories/gerant_repository.dart';

class GerantGetTabelsUseCase {
  final GerantRespository repository;

  GerantGetTabelsUseCase(this.repository);

  Stream<List<TableModel>> call() {
    return repository.getTabels();
  }
}
