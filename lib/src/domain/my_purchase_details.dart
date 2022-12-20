import 'package:flutter/foundation.dart';

@immutable
class MyProductDetails {
  final String id;
  final String title;
  final String description;
  final num price;
  final num rawPrice;
  final String currencyCode;
  final String currencySymbol;

//<editor-fold desc="Data Methods">

  const MyProductDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rawPrice,
    required this.currencyCode,
    this.currencySymbol = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyProductDetails &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          rawPrice == other.rawPrice &&
          currencyCode == other.currencyCode &&
          currencySymbol == other.currencySymbol);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      rawPrice.hashCode ^
      currencyCode.hashCode ^
      currencySymbol.hashCode;

  @override
  String toString() {
    return 'MyProductDetails{ id: $id, title: $title, description: $description, price: $price, rawPrice: $rawPrice, currencyCode: $currencyCode, currencySymbol: $currencySymbol,}';
  }

  MyProductDetails copyWith({
    String? id,
    String? title,
    String? description,
    num? price,
    num? rawPrice,
    String? currencyCode,
    String? currencySymbol,
  }) {
    return MyProductDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      rawPrice: rawPrice ?? this.rawPrice,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rawPrice': rawPrice,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
    };
  }

  factory MyProductDetails.fromMap(Map<String, dynamic> map) {
    return MyProductDetails(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      rawPrice: map['rawPrice'] as num,
      currencyCode: map['currencyCode'] as String,
      currencySymbol: map['currencySymbol'] as String,
    );
  }

//</editor-fold>
}
