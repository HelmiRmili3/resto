import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  String id;
  int number;
  int places;
  bool isReserved; // New field indicating whether the table is reserved or not

  TableModel({
    required this.id,
    required this.number,
    required this.places,
    required this.isReserved,
  });

  // JSON serialization
  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      number: json['number'],
      places: json['places'],
      isReserved:
          json['isReserved'] ?? false, // Default to false if not provided
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'places': places,
      'isReserved': isReserved,
    };
  }

  // Snapshot conversion
  factory TableModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TableModel.fromJson(data);
  }

  // copyWith method
  TableModel copyWith({
    String? id,
    int? number,
    int? places,
    bool? isReserved,
  }) {
    return TableModel(
      id: id ?? this.id,
      number: number ?? this.number,
      places: places ?? this.places,
      isReserved: isReserved ?? this.isReserved,
    );
  }
}
