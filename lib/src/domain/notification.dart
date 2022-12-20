import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Notification {
  final String id;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const Notification({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          message == other.message &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^ message.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;

  @override
  String toString() {
    return 'Notification{ id: $id, message: $message, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  Notification copyWith({
    String? id,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notification(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt == DateTime.now() ? FieldValue.serverTimestamp() : createdAt,
      'updatedAt': updatedAt == DateTime.now() ? FieldValue.serverTimestamp() : updatedAt,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] as String,
      message: map['message'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}
