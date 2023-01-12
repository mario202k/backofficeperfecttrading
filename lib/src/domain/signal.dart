import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Signal {
  final String id;
  final String name;
  final int pips;
  final num entry;
  final num stopLoss;
  final num takeProfit;
  final bool isBuy;
  final bool isClosed;
  final bool isVip;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">

  const Signal({
    required this.id,
    required this.name,
    required this.pips,
    required this.entry,
    required this.stopLoss,
    required this.takeProfit,
    required this.isBuy,
    required this.isClosed,
    required this.isVip,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Signal &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              pips == other.pips &&
              entry == other.entry &&
              stopLoss == other.stopLoss &&
              takeProfit == other.takeProfit &&
              isBuy == other.isBuy &&
              isClosed == other.isClosed &&
              isVip == other.isVip &&
              createdAt == other.createdAt &&
              updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      pips.hashCode ^
      entry.hashCode ^
      stopLoss.hashCode ^
      takeProfit.hashCode ^
      isBuy.hashCode ^
      isClosed.hashCode ^
      isVip.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;


  @override
  String toString() {
    return 'Signal{id: $id, name: $name, pips: $pips, entry: $entry, stopLoss: $stopLoss, takeProfit: $takeProfit, isBuy: $isBuy, isClosed: $isClosed, isVip: $isVip, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Signal copyWith({
    String? id,
    String? name,
    int? pips,
    num? entry,
    num? stopLoss,
    num? takeProfit,
    bool? isBuy,
    bool? isClosed,
    bool? isVip,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Signal(
      id: id ?? this.id,
      name: name ?? this.name,
      pips: pips ?? this.pips,
      entry: entry ?? this.entry,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit: takeProfit ?? this.takeProfit,
      isBuy: isBuy ?? this.isBuy,
      isClosed: isClosed ?? this.isClosed,
      isVip: isVip ?? this.isVip,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pips': pips,
      'entry': entry,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'isBuy': isBuy,
      'isClosed': isClosed,
      'isVip': isVip,
      'createdAt': createdAt == DateTime.now()
          ? FieldValue.serverTimestamp()
          : createdAt,
      'updatedAt': updatedAt == DateTime.now()
          ? FieldValue.serverTimestamp()
          : updatedAt,
    };
  }

  factory Signal.fromMap(Map<String, dynamic> map) {
    return Signal(
      id: map['id'] as String,
      name: map['name'] as String,
      pips: map['pips'] as int,
      entry: map['entry'] as num,
      stopLoss: map['stopLoss'] as num,
      takeProfit: map['takeProfit'] as num,
      isBuy: map['isBuy'] as bool,
      isClosed: map['isClosed'] as bool,
      isVip: map['isVip'] as bool,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

//</editor-fold>
}
