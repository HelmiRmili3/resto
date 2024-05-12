import 'package:resto/data/models/plat_model.dart';
import 'package:resto/domain/repositories/chef_repository.dart';

class ChefAddPlatUseCase {
  final ChefRespository repository;

  ChefAddPlatUseCase(this.repository);

  Future<void> call(PlatModel plat) {
    return repository.addPlat(plat);
  }
}
