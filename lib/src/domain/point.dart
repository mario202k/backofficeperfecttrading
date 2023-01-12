import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Point{
  final String id;
  final MapEntry<String,num> x;
  final MapEntry<String,num> y;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const Point({
    required this.id,
    required this.x,
    required this.y,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Point &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          x == other.x &&
          y == other.y &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      x.hashCode ^
      y.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'Point{ id: $id, x: $x, y: $y, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  Point copyWith({
    String? id,
    MapEntry<String,num>? x,
    MapEntry<String,num>? y,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Point(
      id: id ?? this.id,
      x: x ?? this.x,
      y: y ?? this.y,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'x': {x.key:x.value},
      'y': {y.key:y.value},
      'createdAt': createdAt == DateTime.now() ? FieldValue.serverTimestamp() : createdAt,
      'updatedAt': updatedAt == DateTime.now() ? FieldValue.serverTimestamp() : updatedAt,
    };
  }

  factory Point.fromMap(Map<String, dynamic> map) {
    final entryX = (map['x'] as Map).entries.first;
    final entryY = (map['y'] as Map).entries.first;
    return Point(
      id: map['id'] as String,
      x: MapEntry<String,num>(entryX.key, entryX.value as num),
      y: MapEntry<String,num>(entryY.key, entryY.value as num),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

//</editor-fold>
}