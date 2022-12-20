import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/firestore_service.dart';
import '../domain/graph.dart';
import '../domain/point.dart';
import 'paths.dart';

final graphRepositoryProvider = Provider.autoDispose<GraphRepository>((ref) {
  return GraphRepository();
});

abstract class GraphRepositoryInterface {
  Future<void> setGraph({required Graph graph});

  Future<void> deleteGraph({required String graphId});

  Future<List<Graph>> getGraphs();

  Future<Graph> getGraph({required String graphId});

  Future<void> setPoint({required String graphId, required Point point});

  Future<List<Point>> getPoints({required String graphId});
}

class GraphRepository implements GraphRepositoryInterface {
  final _service = FirestoreService.instance;

  @override
  Future<void> setGraph({required Graph graph}) {
    return _service.setDataWithAwait(
        path: Paths.graph(graphId: graph.id), data: graph.toMap());
  }

  @override
  Future<void> deleteGraph({required String graphId}) {
    return _service.deleteDoc(path: Paths.graph(graphId: graphId));
  }

  @override
  Future<List<Graph>> getGraphs() {
    return _service.collectionFuture(
        path: Paths.graphs(), builder: (data) => Graph.fromMap(data));
  }

  @override
  Future<Graph> getGraph({required String graphId}) {
    return _service.getDoc(
        path: Paths.graph(graphId: graphId), builder: (data) => Graph.fromMap(data));
  }

  @override
  Future<void> setPoint({required String graphId, required Point point}) {
    return _service.setDataWithAwait(
        path: Paths.point(graphId: graphId, pointId: point.id), data: point.toMap());
  }

  @override
  Future<List<Point>> getPoints({required String graphId}) {
    return _service.collectionFuture(
        path: Paths.points(graphId: graphId),
        builder: (data) => Point.fromMap(data),
        queryBuilder: (query) => query.orderBy('createdAt', descending: true));
  }
}
