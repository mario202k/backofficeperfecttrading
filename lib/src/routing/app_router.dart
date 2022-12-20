import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../domain/signal.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/update_signal/update_signal_screen.dart';
import 'go_router_refresh_stream.dart';
import 'not_found_screen.dart';

enum AppRoute {
  login,
  home,
  updateSignal
}

final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: false,
    initialLocation: "/${AppRoute.login.name}",
    redirect: (_, state) {
      print("redirect");
      final currentUser = FirebaseAuth.instance.currentUser;

      print("currentUser: $currentUser");
      if (currentUser == null && state.location.contains("/${AppRoute.home.name}")) {
        return "/${AppRoute.login.name}";
      }

      if (currentUser != null && state.location.contains("/${AppRoute.login.name}")) {
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
              return UpdateSignalScreen(signal: signal,);
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