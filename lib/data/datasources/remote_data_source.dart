import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resto/core/strings.dart';
import 'package:resto/data/models/order_model.dart';
import 'package:resto/data/models/plat_model.dart';
// import 'package:resto/data/models/reservation_model.dart';
import 'package:resto/data/models/table_model.dart';
import 'package:resto/data/models/transcation_model.dart';
import 'package:resto/data/models/user_model.dart';

abstract class RemoteDataSource {
  //authentication
  Future<void> addUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<UserCredential?> signUpUser(String email, String password);
  Future<UserCredential?> signInUser(String email, String password);
  Future<void> forgetPassword(String email);
  Future<void> logoutUser();

  //add orders and reservations
  Future<void> addReservation(String tableId);
  Future<void> addTable(TableModel table);
  Future<void> addPlate(PlatModel plat);
  Future<void> addOrder(OrderModel order);

  //get all collections
  // Stream<List<ReservationModel>> getUserReservations();
  Stream<List<OrderModel>> getUserOrders();
  Stream<List<OrderModel>> getOrders();
  Stream<List<TableModel>> getTables();
  Stream<List<PlatModel>> getPlates();

  Stream<List<TransactionModel>> fetchTransactions();

  Stream<List<UserModel>> getUsers();
  Stream<List<PlatModel>> getMenu();

  //delete docs
  Future<void> removeUser(String docId);
  Future<void> removePlate(String docId);
  Future<void> removeTable(String docId);

  // manipulate state
  Future<void> orderReady(String orderId);
  Future<void> orderPayed(String orderId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<void> addUser(UserModel user) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(Strings.usersCollection);
      await users.doc(user.id).set(user.toJson());
    } catch (e) {
      //  print("Firestore error: $e");
    }
  }

  @override
  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserCredential?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      //  print(e.toString());
      return null;
    }
  }

  @override
  Future<UserCredential?> signUpUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return;
    } catch (e) {
      // Handle sign-up errors
      //print(e.toString());
      return;
    }
  }

  @override
  Future<void> addOrder(OrderModel order) async {
    try {
      DocumentReference allOrders = FirebaseFirestore.instance
          .collection(Strings.ordersCollection)
          .doc(order.id);
      await allOrders.set(order.toJson());
    } catch (e) {
      //  print("Firestore error in add order : $e");
    }
  }

  @override
  Future<void> removeUser(String docId) async {
    FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .doc(docId)
        .delete();
  }

  @override
  Future<void> removePlate(String docId) async {
    FirebaseFirestore.instance
        .collection(Strings.menuCollection)
        .doc(docId)
        .delete();
  }

  @override
  Future<void> removeTable(String docId) async {
    FirebaseFirestore.instance
        .collection(Strings.tablesCollection)
        .doc(docId)
        .delete();
  }

  @override
  Future<void> addPlate(PlatModel plat) async {
    try {
      CollectionReference menu =
          FirebaseFirestore.instance.collection(Strings.menuCollection);
      await menu.doc(plat.id).set(plat.toJson());
    } catch (e) {
      // print("Firestore error: $e");
    }
  }

  @override
  Future<void> addReservation(String tableId) async {
    try {
      // Get reference to the document
      DocumentReference table = FirebaseFirestore.instance
          .collection(Strings.tablesCollection)
          .doc(tableId);

      // Update the document with isReserved field set to true
      await table.update({'isReserved': true});
    } catch (e) {
      print("Firestore error: $e");
    }
  }

  @override
  Future<void> addTable(TableModel table) async {
    try {
      CollectionReference tables =
          FirebaseFirestore.instance.collection(Strings.tablesCollection);
      // Set the ID before adding the document
      await tables.doc(table.id).set(table.toJson());
    } catch (e) {
      print("Firestore error: $e");
    }
  }

  @override
  Stream<List<PlatModel>> getMenu() {
    return FirebaseFirestore.instance
        .collection(Strings.menuCollection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                PlatModel.fromSnapshot(documentSnapshot))
            .toList());
  }

  @override
  Stream<List<TableModel>> getTables() {
    return FirebaseFirestore.instance
        .collection(Strings.tablesCollection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                TableModel.fromSnapshot(documentSnapshot))
            .toList());
  }

  @override
  Stream<List<OrderModel>> getUserOrders() {
    return FirebaseFirestore.instance
        .collection(Strings.ordersCollection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                OrderModel.fromSnapshot(documentSnapshot))
            .toList());
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .snapshots()
        .map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs
              .map(
                (DocumentSnapshot documentSnapshot) =>
                    UserModel.fromSnapshot(documentSnapshot),
              )
              .toList(),
        );
  }

  @override
  Future<UserModel> getUser(String id) async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .doc(id)
        .get();
    return UserModel.fromSnapshot(user);
  }

  @override
  Stream<List<OrderModel>> getOrders() {
    return FirebaseFirestore.instance
        .collection(Strings.ordersCollection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                OrderModel.fromSnapshot(documentSnapshot))
            .toList());
  }

  @override
  Stream<List<PlatModel>> getPlates() {
    return FirebaseFirestore.instance
        .collection(Strings.menuCollection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                PlatModel.fromSnapshot(documentSnapshot))
            .toList());
  }

  @override
  Future<void> orderPayed(String orderId) async {
    try {
      // Get a reference to the order document
      DocumentReference orderRef = FirebaseFirestore.instance
          .collection(Strings.ordersCollection)
          .doc(orderId);

      // Update the order document to mark it as payed
      await orderRef.update({'isPayed': true});

      // Get the order document to retrieve the table value
      DocumentSnapshot orderSnapshot = await orderRef.get();
      if (orderSnapshot.exists) {
        // Get the table value from the order document by casting it to a Map<String, dynamic>
        Map<String, dynamic> data =
            orderSnapshot.data() as Map<String, dynamic>;
        String tableId = data['table'];
        String orderId = data['id'];
        double amount = data['prix'];
        String orderBy = data['orderedBy'];
        TransactionModel reservation = TransactionModel(
          id: orderId,
          amount: amount,
          orderId: orderId,
          orderedBy: orderBy,
          dateTime: DateTime.now(),
        );
        // Get a reference to the table document
        DocumentReference tableRef = FirebaseFirestore.instance
            .collection(Strings.tablesCollection)
            .doc(tableId);
        await FirebaseFirestore.instance
            .collection(Strings.transactionsCollection)
            .doc(orderId)
            .set(reservation.toJson());

        // Update the table document to mark it as not reserved
        await tableRef.update({'isReserved': false});
      }
    } catch (e) {
      print("Firestore error: $e");
    }
  }

  @override
  Future<void> orderReady(String orderId) async {
    try {
      DocumentReference order = FirebaseFirestore.instance
          .collection(Strings.ordersCollection)
          .doc(orderId);
      await order.update({'isReady': true});
    } catch (e) {
      print("Firestore error: $e");
    }
  }

  @override
  Stream<List<TransactionModel>> fetchTransactions() {
    return FirebaseFirestore.instance
        .collection(Strings.transactionsCollection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) =>
                TransactionModel.fromSnapshot(documentSnapshot))
            .toList());
  }
}
