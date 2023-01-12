import 'package:backoffice/src/domain/data_fl_chart.dart';
import 'package:backoffice/src/domain/testimony.dart';
import 'package:backoffice/src/presentation/update_or_add_app_user/update_or_add_app_user.dart';
import 'package:backoffice/src/presentation/update_or_add_testimony/update_or_add_testimony_screen.dart';
import 'package:backoffice/src/presentation/update_version/update_version.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/app_user.dart';
import '../domain/app_version.dart';
import '../domain/signal.dart';
import '../presentation/edit_points/edit_points_screen.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/update_signal/update_signal_screen.dart';
import 'go_router_refresh_stream.dart';
import 'not_found_screen.dart';

enum AppRoute {
  login,
  home,
  updateSignal,
  updateOrAddAppUser,
  updateOrAddTestimony,
  editPoints,
  updateVersion
}

final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: false,
    initialLocation: "/${AppRoute.login.name}",
    redirect: (_, state) {
      print("redirect");
      final currentUser = FirebaseAuth.instance.currentUser;

      print("currentUser: $currentUser");
      if (currentUser == null &&
          state.location.contains("/${AppRoute.home.name}")) {
        return "/${AppRoute.login.name}";
      }

      if (currentUser != null &&
          state.location.contains("/${AppRoute.login.name}")) {
        return "/${AppRoute.home.name}";
      }

      return null;
    },
    refreshListenable:
        GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    routes: [
      GoRoute(
        path: "/${AppRoute.home.name}",
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: AppRoute.updateSignal.name,
            name: AppRoute.updateSignal.name,
            redirect: (_, state) {
              final signal = state.extra as Signal?;
              if (signal == null) {
                return "/${AppRoute.home.name}";
              }
              return null;
            },
            builder: (context, state) {
              final signal = state.extra as Signal;
              return UpdateSignalScreen(
                signal: signal,
              );
            },
          ),
          GoRoute(
            path: AppRoute.updateOrAddAppUser.name,
            name: AppRoute.updateOrAddAppUser.name,
            builder: (context, state) {
              final appUser = state.extra as AppUser?;
              return UpdateOrAddAppUserScreen(
                appUser: appUser,
              );
            },
          ),
          GoRoute(
            path: AppRoute.updateOrAddTestimony.name,
            name: AppRoute.updateOrAddTestimony.name,
            builder: (context, state) {
              final testimony = state.extra as Testimony?;
              return UpdateOrAddTestimonyScreen(
                testimony: testimony,
              );
            },
          ),
          GoRoute(
            path: AppRoute.editPoints.name,
            name: AppRoute.editPoints.name,
            redirect: (_, state) {
              final dataFlChart = state.extra as DataFlChart?;
              if (dataFlChart == null) {
                return "/${AppRoute.home.name}";
              }
              return null;
            },
            builder: (context, state) {
              final dataFlChart = state.extra as DataFlChart;
              return EditPointScreen(
                dataFlChart: dataFlChart,
              );
            },
          ),
          GoRoute(
            path: AppRoute.updateVersion.name,
            name: AppRoute.updateVersion.name,
            builder: (context, state) {
              final appVersion = state.extra as AppVersion?;
              return UpdateVersion(
                appVersion: appVersion,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: "/${AppRoute.login.name}",
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
