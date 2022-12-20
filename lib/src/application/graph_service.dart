import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/graph_repository.dart';
import '../domain/data_fl_chart.dart';

final graphServiceProvider = Provider.autoDispose<GraphService>((ref) {
  return GraphService(graphRepository: ref.watch(graphRepositoryProvider));
});

abstract class GraphServiceInterface {
  Future<List<DataFlChart>> getGraphs();
}

class GraphService implements GraphServiceInterface {
  final GraphRepository graphRepository;

  GraphService({required this.graphRepository});

  @override
  Future<List<DataFlChart>> getGraphs() async {
    final dataFlChart = <DataFlChart>[];
    final graphs = await graphRepository.getGraphs();

    for (final graph in graphs) {
      final points = await graphRepository.getPoints(graphId: graph.id);

      dataFlChart.add(DataFlChart(
        spots: points
            .map((e) => FlSpot(e.x.key.toDouble(), e.y.key.toDouble()))
            .toList(),
        horizontalInterval: graph.horizontalInterval.toDouble(),
        verticalInterval: graph.verticalInterval.toDouble(),
        bottomTitleWidgets: (value, meta) {
          String text = '';
          for (final element in points) {
            if (element.x.key.toDouble() == value) {
              text = element.x.value;
              break;
            }
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(text),
          );
        },
        leftTitleWidgets: (value, meta) {
          String text = '';
          for (final element in points) {
            if (element.y.key.toDouble() == value) {
              text = element.x.value;
              break;
            }
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(text),
          );
        },
      ));
    }

    return dataFlChart;
  }
}
