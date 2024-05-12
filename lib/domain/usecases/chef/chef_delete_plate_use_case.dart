import 'package:resto/domain/repositories/chef_repository.dart';

class ChefDeletePlatUseCase {
  final ChefRespository repository;

  ChefDeletePlatUseCase(this.repository);

  Future<void> call(String platId) {
    return repository.deletePlat(platId);
  }
}
