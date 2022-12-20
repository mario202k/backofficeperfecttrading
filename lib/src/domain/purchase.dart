import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'my_purchase_details.dart';

@immutable
class Purchase {
  final String id;
  final MyProductDetails productDetails;
  final DateTime premiumStartAt;
  final DateTime premiumEndAt;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">

  const Purchase({
    required this.id,
    required this.productDetails,
    required this.premiumStartAt,
    required this.premiumEndAt,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          productDetails == other.productDetails &&
          premiumStartAt == other.premiumStartAt &&
          premiumEndAt == other.premiumEndAt &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^
      productDetails.hashCode ^
      premiumStartAt.hashCode ^
      premiumEndAt.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'Purchase{ id: $id, productDetails: $productDetails, premiumStartAt: $premiumStartAt, premiumEndAt: $premiumEndAt, createdAt: $createdAt,}';
  }

  Purchase copyWith({
    String? id,
    MyProductDetails? productDetails,
    DateTime? premiumStartAt,
    DateTime? premiumEndAt,
    DateTime? createdAt,
  }) {
    return Purchase(
      id: id ?? this.id,
      productDetails: productDetails ?? this.productDetails,
      premiumStartAt: premiumStartAt ?? this.premiumStartAt,
      premiumEndAt: premiumEndAt ?? this.premiumEndAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productDetails': productDetails,
      'premiumStartAt': premiumStartAt,
      'premiumEndAt': premiumEndAt,
      'createdAt': createdAt == DateTime.now() ? FieldValue.serverTimestamp() : createdAt,
    };
  }

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] as String,
      productDetails: map['productDetails'] as MyProductDetails,
      premiumStartAt: (map['premiumStartAt'] as Timestamp).toDate(),
      premiumEndAt: (map['premiumEndAt'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}
