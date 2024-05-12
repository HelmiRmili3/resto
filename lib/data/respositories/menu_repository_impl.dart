// import 'package:dartz/dartz.dart';
// import 'package:resto/data/models/order_model.dart';
// import 'package:resto/data/models/plat_model.dart';
// import 'package:resto/data/models/reservation_model.dart';
// import 'package:resto/data/models/table_model.dart';
// import 'package:resto/domain/repositories/client_repository.dart';
// import 'package:resto/shared/errors/failure.dart';

// import '../../domain/repositories/menu_repository.dart';
// import '../datasources/remote_data_source.dart';

// class MenuRepositoryImpl implements ClientRespository {
//   final RemoteDataSource remoteDataSource;

//   MenuRepositoryImpl({
//     required this.remoteDataSource,
//   });

//   @override
//   Future<Either<Failure, void>> addOrder(OrderModel order) async {
//     try {
//       final result = await remoteDataSource.addOrder(order);
//       return Right(result);
//     } catch (e) {
//       return Left(Failure("Server error : ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> addReservation(
//       ReservationModel reservation) async {
//     try {
//       final result = await remoteDataSource.addReservation(reservation);
//       return Right(result);
//     } catch (e) {
//       return Left(Failure("Server error : ${e.toString()}"));
//     }
//   }

//   @override
//   Stream<List<ReservationModel>> getUserReservations() {
//     return remoteDataSource.getUserReservations().handleError((error) {
//       throw Failure("Error: ${error.toString()}");
//     });
//   }

//   @override
//   Stream<List<TableModel>> getTabels() {
//     try {
//       final result = remoteDataSource.getTables();
//       return result.handleError((error) {
//         throw Failure("Server error: $error");
//       });
//     } catch (e) {
//       throw Failure("Server error: ${e.toString()}");
//     }
//   }

//   @override
//   Stream<List<PlatModel>> getPlats() {
//     return remoteDataSource.getPlates().handleError((error) {
//       throw Failure("Error: ${error.toString()}");
//     });
//   }
// }
