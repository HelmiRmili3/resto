import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final double amount;
  final String orderId;
  final String orderedBy;
  final DateTime dateTime;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.orderId,
    required this.orderedBy,
    required this.dateTime,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      orderId: json['orderId'],
      orderedBy: json['orderedBy'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'orderId': orderId,
      'orderedBy': orderedBy,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TransactionModel.fromJson(data);
  }

  TransactionModel copyWith({
    String? id,
    double? amount,
    String? orderId,
    String? orderedBy,
    DateTime? dateTime,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      orderId: orderId ?? this.orderId,
      orderedBy: orderedBy ?? this.orderedBy,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
