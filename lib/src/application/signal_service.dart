import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../data/signal_repository.dart';
import '../domain/signal.dart';

final signalServiceProvider = Provider.autoDispose<SignalService>((ref) {
  return SignalService(
    signalRepository: ref.read(signalRepositoryProvider),
  );
});

abstract class SignalServiceInterface {
  Future<Result<void, AppException>> setSignal({required Signal signal});

  Future<Signal> getSignal({required String signalId});

  Future<List<Signal>> getSignals();

  Future<Result<void, AppException>> deleteSignal({required String signalId});

  Future<void> updateSignal(
      {required MapEntry<String, dynamic> entry, required String signalId});

  Future<void> setSignals({required List<Signal> signals});
}

class SignalService implements SignalServiceInterface {
  final SignalRepository signalRepository;

  SignalService({required this.signalRepository});

  @override
  Future<Result<void, AppException>> deleteSignal(
      {required String signalId}) async {
    try {
      await signalRepository.deleteSignal(signalId: signalId);

      return const Success(null);
    } on AppException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Signal> getSignal({required String signalId}) {
    return signalRepository.getSignal(signalId: signalId);
  }

  @override
  Future<List<Signal>> getSignals() {
    return signalRepository.getSignals();
  }

  @override
  Future<Result<void, AppException>> setSignal({required Signal signal}) async {
    try {
      await signalRepository.setSignal(signal: signal);
      return const Success(null);
    } on AppException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<void> setSignals({required List<Signal> signals}) {
    return signalRepository.setSignals(signals: signals);
  }

  @override
  Future<void> updateSignal(
      {required MapEntry<String, dynamic> entry, required String signalId}) {
    return signalRepository.updateSignal(entry: entry, signalId: signalId);
  }
}
