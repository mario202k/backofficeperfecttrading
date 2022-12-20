import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum GraphType {
  monthly,
  yearly,
}

@immutable
class Graph {
  final String id;
  final GraphType type;
  final String? title;
  final String? description;
  final num horizontalInterval;
  final num verticalInterval;
  final num? xMin;
  final num? xMax;
  final num? yMin;
  final num? yMax;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const Graph({
    required this.id,
    required this.type,
    this.title,
    this.description,
    required this.horizontalInterval,
    required this.verticalInterval,
    this.xMin,
    this.xMax,
    this.yMin,
    this.yMax,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Graph &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          title == other.title &&
          description == other.description &&
          horizontalInterval == other.horizontalInterval &&
          verticalInterval == other.verticalInterval &&
          xMin == other.xMin &&
          xMax == other.xMax &&
          yMin == other.yMin &&
          yMax == other.yMax &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      title.hashCode ^
      description.hashCode ^
      horizontalInterval.hashCode ^
      verticalInterval.hashCode ^
      xMin.hashCode ^
      xMax.hashCode ^
      yMin.hashCode ^
      yMax.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'Graph{ id: $id, type: $type, title: $title, description: $description, horizontalInterval: $horizontalInterval, verticalInterval: $verticalInterval, xMin: $xMin, xMax: $xMax, yMin: $yMin, yMax: $yMax, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  Graph copyWith({
    String? id,
    GraphType? type,
    String? title,
    String? description,
    num? horizontalInterval,
    num? verticalInterval,
    num? xMin,
    num? xMax,
    num? yMin,
    num? yMax,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Graph(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      horizontalInterval: horizontalInterval ?? this.horizontalInterval,
      verticalInterval: verticalInterval ?? this.verticalInterval,
      xMin: xMin ?? this.xMin,
      xMax: xMax ?? this.xMax,
      yMin: yMin ?? this.yMin,
      yMax: yMax ?? this.yMax,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'horizontalInterval': horizontalInterval,
      'verticalInterval': verticalInterval,
      'xMin': xMin,
      'xMax': xMax,
      'yMin': yMin,
      'yMax': yMax,
      'createdAt': createdAt == DateTime.now() ? FieldValue.serverTimestamp() : createdAt,
      'updatedAt': updatedAt == DateTime.now() ? FieldValue.serverTimestamp() : updatedAt,
    };
  }

  factory Graph.fromMap(Map<String, dynamic> map) {
    return Graph(
      id: map['id'] as String,
      type: map['type'] as GraphType,
      title: map['title'] as String,
      description: map['description'] as String,
      horizontalInterval: map['horizontalInterval'] as num,
      verticalInterval: map['verticalInterval'] as num,
      xMin: map['xMin'] as num,
      xMax: map['xMax'] as num,
      yMin: map['yMin'] as num,
      yMax: map['yMax'] as num,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}
