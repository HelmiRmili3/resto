import 'package:resto/data/models/table_model.dart';
import 'package:resto/domain/repositories/client_repository.dart';

class GetTablesUseCase {
  final ClientRespository repository;

  GetTablesUseCase(this.repository);

  Stream<List<TableModel>> call() {
    return repository.getTabels();
  }
}
