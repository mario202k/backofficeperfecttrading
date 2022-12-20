import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../application/firestore_service.dart';
import '../domain/signal.dart';
import 'paths.dart';

final signalRepositoryProvider = Provider.autoDispose<SignalRepository>((ref) {
  return SignalRepository();
});

abstract class SignalRepositoryInterface {
  Future<void> setSignal({required Signal signal});

  Future<Signal> getSignal({required String signalId});

  Future<List<Signal>> getSignals();

  Future<void> deleteSignal({required String signalId});

  Future<void> updateSignal(
      {required MapEntry<String, dynamic> entry, required String signalId});

  Future<void> setSignals({required List<Signal> signals});
}

class SignalRepository implements SignalRepositoryInterface {
  final _service = FirestoreService.instance;

  @override
  Future<void> setSignal({required Signal signal}) {
    return _service.setDataWithAwait(
        path: Paths.signal(signalId: signal.id), data: signal.toMap());
  }

  @override
  Future<Signal> getSignal({required String signalId}) {
    return _service.getDoc(
        path: Paths.signal(signalId: signalId),
        builder: (data) => Signal.fromMap(data));
  }

  @override
  Future<List<Signal>> getSignals() {
    return _service.collectionFuture(
      path: Paths.signals(),
      builder: (data) => Signal.fromMap(data),
      queryBuilder: (query) =>
          query.orderBy('createdAt', descending: true).limit(40),
    );
  }

  @override
  Future<void> updateSignal(
      {required MapEntry<String, dynamic> entry, required String signalId}) {
    return _service.updateData(
        path: Paths.signal(signalId: signalId), data: entry);
  }

  @override
  Future<void> setSignals({required List<Signal> signals}) async {
    for (Signal signal in signals) {
      await setSignal(signal: signal);
    }
    return Future.value();
  }

  @override
  Future<void> deleteSignal({required String signalId}) {
    return _service.deleteDoc(path: Paths.signal(signalId: signalId));
  }
}
