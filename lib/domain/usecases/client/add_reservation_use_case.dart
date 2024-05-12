import 'package:resto/domain/repositories/client_repository.dart';

class AddReservationUseCase {
  final ClientRespository repository;

  AddReservationUseCase(this.repository);

  Future<void> call(String tableId) async {
    return repository.addReservation(tableId);
  }
}
