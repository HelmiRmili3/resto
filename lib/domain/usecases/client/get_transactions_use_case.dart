import 'package:resto/data/models/transcation_model.dart';
import 'package:resto/domain/repositories/client_repository.dart';

class GetTransactionsUseCase {
  final ClientRespository repository;

  GetTransactionsUseCase(this.repository);

  Stream<List<TransactionModel>> call() {
    return repository.getTranscations();
  }
}
