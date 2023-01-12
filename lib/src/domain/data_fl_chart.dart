import 'package:backoffice/src/domain/point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'graph.dart';

@immutable
class DataFlChart {
  final double? horizontalInterval;
  final double? verticalInterval;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final int? totalPipsWon;
  final int? totalTrades;
  final List<FlSpot> spots;
  final Graph graph;
  final List<Point> points;
  final Widget Function(double value, TitleMeta meta) bottomTitleWidgets;
  final Widget Function(double value, TitleMeta meta) leftTitleWidgets;

  const DataFlChart(  {
    this.horizontalInterval,
    this.verticalInterval,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.totalPipsWon, this.totalTrades,
    required this.graph, required this.points,
    required this.spots,
    required this.bottomTitleWidgets,
    required this.leftTitleWidgets,
  });

  @override
  String toString() {
    return 'DataFlChart{horizontalInterval: $horizontalInterval, verticalInterval: $verticalInterval, minX: $minX, maxX: $maxX, minY: $minY, maxY: $maxY, spots: $spots, bottomTitleWidgets: $bottomTitleWidgets, leftTitleWidgets: $leftTitleWidgets}';
  }
}
