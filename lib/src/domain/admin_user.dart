import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class AdminUser{
  final String id;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const AdminUser({
    required this.id,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdminUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          password == other.password &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      password.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'AdminUser{ id: $id, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  AdminUser copyWith({
    String? id,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminUser(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'createdAt': createdAt == DateTime.now() ? FieldValue.serverTimestamp() : createdAt,
      'updatedAt': updatedAt == DateTime.now() ? FieldValue.serverTimestamp() : updatedAt,
    };
  }

  factory AdminUser.fromMap(Map<String, dynamic> map) {
    return AdminUser(
      id: map['id'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}