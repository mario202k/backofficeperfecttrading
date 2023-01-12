import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Testimony {
  final String id;
  final String name;
  final String content;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const Testimony({
    required this.id,
    required this.name,
    required this.content,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Testimony &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          content == other.content &&
          date == other.date &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      content.hashCode ^
      date.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'Testimony{ id: $id, name: $name, content: $content, date: $date, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  Testimony copyWith({
    String? id,
    String? name,
    String? content,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Testimony(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'content': content,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Testimony.fromMap(Map<String, dynamic> map) {
    return Testimony(
      id: map['id'] as String,
      name: map['name'] as String,
      content: map['content'] as String,
      date: (map['date'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}
