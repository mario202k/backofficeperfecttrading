import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

@immutable
class DataFlChart {
  final double? horizontalInterval;
  final double? verticalInterval;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final List<FlSpot> spots;
  final Widget Function(double value, TitleMeta meta) bottomTitleWidgets;
  final Widget Function(double value, TitleMeta meta) leftTitleWidgets;

  const DataFlChart({
    this.horizontalInterval,
    this.verticalInterval,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    required this.spots,
    required this.bottomTitleWidgets,
    required this.leftTitleWidgets,
  });

  @override
  String toString() {
    return 'DataFlChart{horizontalInterval: $horizontalInterval, verticalInterval: $verticalInterval, minX: $minX, maxX: $maxX, minY: $minY, maxY: $maxY, spots: $spots, bottomTitleWidgets: $bottomTitleWidgets, leftTitleWidgets: $leftTitleWidgets}';
  }
}
