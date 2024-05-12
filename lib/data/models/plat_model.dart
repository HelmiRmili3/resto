import 'package:cloud_firestore/cloud_firestore.dart';

class PlatModel {
  String id;
  String name;
  double prix;
  String imageUrl;
  String description;
  List<String> ingredients;

  PlatModel({
    required this.id,
    required this.name,
    required this.prix,
    required this.imageUrl,
    required this.description,
    required this.ingredients,
  });

  // JSON serialization
  factory PlatModel.fromJson(Map<String, dynamic> json) {
    return PlatModel(
      id: json['id'],
      name: json['name'],
      prix: json['prix'].toDouble(),
      imageUrl: json['imageUrl'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'prix': prix,
      'imageUrl': imageUrl,
      'description': description,
      'ingredients': ingredients,
    };
  }

  // Snapshot conversion
  factory PlatModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PlatModel.fromJson(data);
  }

  // copyWith method
  PlatModel copyWith({
    String? id,
    String? name,
    double? prix,
    String? imageUrl,
    String? description,
    List<String>? ingredients,
  }) {
    return PlatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      prix: prix ?? this.prix,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
