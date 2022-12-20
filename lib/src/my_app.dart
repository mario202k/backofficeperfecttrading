import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/login/language_controller.dart';
import 'routing/app_router.dart';
import 'themes/custom_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      locale: ref.watch(languageProvider),
      onGenerateTitle: (BuildContext context) => 'Perfect Trading',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF5B953)),
          textTheme: CustomTheme.freeTheme(context).textTheme),
    );
  }
}
