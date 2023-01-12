import 'package:backoffice/src/application/app_user_service.dart';
import 'package:backoffice/src/constants/app_sizes.dart';
import 'package:backoffice/src/localization/localized_build_context.dart';
import 'package:backoffice/src/presentation/common_widget/async_value_widget.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/presentation/home/dashboard_page/dashboard_card.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/app_version.dart';
import '../../../routing/app_router.dart';

final numberOfUserProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(appUserServiceProvider).getNumberOfAppUsers();
});
final numberOfDeletedAccountProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(appUserServiceProvider).getNumberOfDeletedAccount();
});
final numberOfLoggedProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(appUserServiceProvider).getNumberOfLogged();
});
final numberOfOnlineProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(appUserServiceProvider).getNumberOfOnline();
});
final numberOfPremiumProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(appUserServiceProvider).getNumberOfPremium();
});

final lastAppVersionProvider =
    FutureProvider.autoDispose<AppVersion?>((ref) async {
  return ref.watch(appUserServiceProvider).getLastAppVersion();
});

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsivePaddingCenter(
      child: Column(
        children: [
          Text(
            context.loc.dashboard,
            style: context.theme.textTheme.headline1,
          ),
          gapH30,
          Row(
            children: [
              DashboardCard(
                  value: ref.watch(numberOfUserProvider),
                  title: context.loc.totalUsers,
                  icon: const Icon(Icons.person)),
              gapW16,
              DashboardCard(
                  value: ref.watch(numberOfPremiumProvider),
                  title: context.loc.totalPremiumUsers,
                  icon: const Icon(Icons.person)),
              gapW16,
              DashboardCard(
                  value: ref.watch(numberOfLoggedProvider),
                  title: context.loc.totalUsersLoggedIn,
                  icon: const Icon(Icons.person)),
            ],
          ),
          gapH30,
          Row(
            children: [
              DashboardCard(
                  value: ref.watch(numberOfDeletedAccountProvider),
                  title: context.loc.totalUsersDeletedAccount,
                  icon: const Icon(Icons.person)),
              gapW16,
              DashboardCard(
                  value: ref.watch(numberOfOnlineProvider),
                  title: context.loc.totalUsersOnline,
                  icon: const Icon(Icons.person)),
            ],
          ),
          gapH30,
          AsyncValueWidget(
              value: ref.watch(lastAppVersionProvider),
              data: (data) {
                if (data == null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No app version found"),
                      gapW16,
                      ElevatedButton(
                          onPressed: () {
                            context.goNamed(AppRoute.updateVersion.name);
                          },
                          child: const Text("Update app version")),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Last app version: ${data.version}"),
                    gapW16,
                    ElevatedButton(
                        onPressed: () {
                          context.goNamed(AppRoute.updateVersion.name,
                              extra: data);
                        },
                        child: const Text("Update app version")),
                  ],
                );
              })
        ],
      ),
    );
  }
}
