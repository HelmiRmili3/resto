import 'package:resto/data/models/plat_model.dart';
import 'package:resto/domain/repositories/client_repository.dart';

class GetPlatsUseCase {
  final ClientRespository repository;

  GetPlatsUseCase(this.repository);

  Stream<List<PlatModel>> call() {
    return repository.getPlats();
  }
}
