import 'package:resto/data/models/plat_model.dart';
import 'package:resto/domain/repositories/chef_repository.dart';

class ChefGetPlatssUseCase {
  final ChefRespository repository;

  ChefGetPlatssUseCase(this.repository);

  Stream<List<PlatModel>> call() {
    return repository.getPlats();
  }
}
