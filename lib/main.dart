import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;


import 'firebase_options.dart';
import 'src/my_app.dart';


final flutterSecureStorageProvider =
    Provider.autoDispose<FlutterSecureStorage>((ref) {
  throw UnimplementedError();
});

Future<void> main() async {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  // * For more info on error handling, see:
  // * https://docs.flutter.dev/testing/errors
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // turn off the # in the URLs on the web
    usePathUrlStrategy();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,);

    runApp(ProviderScope(
      observers: [Logger()],
      overrides: [
        flutterSecureStorageProvider
            .overrideWithValue(const FlutterSecureStorage()),
      ],
      child: const MyApp(),
    ));
  }, (Object error, StackTrace stack) {
    print(stack);
    print(error);
  });
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // debugPrint(
    //     '''{  "provider": "${provider.name ?? provider.runtimeType}",
    //     "previousValue" : $previousValue
    //      "newValue": "$newValue"}''');
  }
}
