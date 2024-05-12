import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resto/data/models/plat_model.dart';

class OrderModel {
  String id;
  List<PlatModel> order;
  double prix;
  String orderedBy;
  int reservationId;
  String table;
  bool isPayed; // New field
  bool isReady; // New field

  OrderModel({
    required this.id,
    required this.order,
    required this.prix,
    required this.orderedBy,
    required this.reservationId,
    required this.table,
    required this.isPayed, // Initialize the new field
    required this.isReady, // Initialize the new field
  });

  // JSON serialization
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> orderJson = json['order'];
    List<PlatModel> orderList =
        orderJson.map((e) => PlatModel.fromJson(e)).toList();
    return OrderModel(
      id: json['id'],
      order: orderList,
      prix: json['prix'].toDouble(),
      orderedBy: json['orderedBy'],
      reservationId: json['reservationId'],
      table: json['table'],
      isPayed: json['isPayed'], // Initialize the new field
      isReady: json['isReady'], // Initialize the new field
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orderJson =
        order.map((e) => e.toJson()).toList();
    return {
      'id': id,
      'order': orderJson,
      'prix': prix,
      'orderedBy': orderedBy,
      'reservationId': reservationId,
      'table': table,
      'isPayed': isPayed, // Add the new field
      'isReady': isReady, // Add the new field
    };
  }

  // Snapshot conversion
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return OrderModel.fromJson(data);
  }

  // copyWith method
  OrderModel copyWith({
    String? id,
    List<PlatModel>? order,
    double? prix,
    String? orderedBy,
    int? reservationId,
    String? table,
    bool? isPayed, // Include the new field
    bool? isReady, // Include the new field
  }) {
    return OrderModel(
      id: id ?? this.id,
      order: order ?? this.order,
      prix: prix ?? this.prix,
      orderedBy: orderedBy ?? this.orderedBy,
      reservationId: reservationId ?? this.reservationId,
      table: table ?? this.table,
      isPayed: isPayed ?? this.isPayed, // Include the new field
      isReady: isReady ?? this.isReady, // Include the new field
    );
  }
}
