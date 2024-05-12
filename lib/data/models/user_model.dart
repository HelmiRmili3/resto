import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resto/utils/enums.dart';

class UserModel {
  String id;
  String name;
  String email;
  Role role;
  String imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  // Create User from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: Role.values[json['role']],
      imageUrl: json['imageUrl'],
    );
  }

  // Create User from a Firebase snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  // Convert User to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.index, // Storing role as index in JSON
      'imageUrl': imageUrl,
    };
  }

  // Copy the User with new values
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    Role? role,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
