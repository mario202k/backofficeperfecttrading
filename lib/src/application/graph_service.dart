import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../data/graph_repository.dart';
import '../domain/data_fl_chart.dart';
import '../domain/graph.dart';
import '../domain/point.dart';

final graphServiceProvider = Provider.autoDispose<GraphService>((ref) {
  return GraphService(graphRepository: ref.watch(graphRepositoryProvider));
});

abstract class GraphServiceInterface {
  Future<List<DataFlChart>> getGraphs();

  Future<void> setGraph({required Graph graph, required List<Point> points});

  Future<void> deleteGraph({required String graphId});

  Future<void> setPoint({required String graphId, required Point point});

  Future<List<Point>> getPoints({required String graphId});
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
      points.sort((a, b) => a.x.value.compareTo(b.x.value));

      dataFlChart.add(DataFlChart(
        spots: points
            .map((e) => FlSpot(e.x.value.toDouble(), e.y.value.toDouble()))
            .toList(),
        horizontalInterval: graph.horizontalInterval.toDouble(),
        verticalInterval: graph.verticalInterval.toDouble(),
        maxX: graph.xMax?.toDouble(),
        minX: graph.xMin?.toDouble(),
        maxY: graph.yMax?.toDouble(),
        minY: graph.yMin?.toDouble(),
        bottomTitleWidgets: (value, meta) {
          String text = '';
          for (final element in points) {
            if (element.x.value.toDouble() == value) {
              text = element.x.key;
              break;
            }
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(text),
          );
        },
        leftTitleWidgets: (value, meta) {
          String text = '$value';
          // for (final element in points) {
          //   if (element.y.value.toDouble() == value) {
          //     text = element.y.key;
          //     break;
          //   }
          // }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(text),
          );
        },
        graph: graph,
        points: points,
      ));
    }

    return dataFlChart;
  }

  @override
  Future<void> deleteGraph({required String graphId}) {
    return graphRepository.deleteGraph(graphId: graphId);
  }

  @override
  Future<List<Point>> getPoints({required String graphId}) {
    return graphRepository.getPoints(graphId: graphId);
  }

  @override
  Future<void> setGraph(
      {required Graph graph, required List<Point> points}) async {
    await graphRepository.setGraph(graph: graph);
    for (final point in points) {
      await graphRepository.setPoint(graphId: graph.id, point: point);
    }
  }

  @override
  Future<Result<void, AppException>> setPoint(
      {required String graphId, required Point point}) async {
    try {
      await graphRepository.setPoint(graphId: graphId, point: point);
      return const Success(null);
    } on AppException catch (e) {
      return Result.error(e);
    }
  }
}
