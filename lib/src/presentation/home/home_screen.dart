import 'package:backoffice/src/localization/localized_build_context.dart';
import 'package:backoffice/src/presentation/home/dashboard_page/dashboard_page.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/assets.dart';
import '../common_widget/drawer/custom_drawer.dart';
import 'app_user_page/app_user_page.dart';
import 'graph_page/graph_page.dart';
import 'signal_page/signal_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late int _index;

  @override
  void initState() {
    super.initState();

    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      child: Scaffold(
          appBar: AppBar(),
          body: IndexedStack(
            index: _index,
            children: const [
              DashboardPage(),
              AppUserPage(),
              SignalPage(),
              GraphPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: context.theme.colorScheme.onBackground,
            currentIndex: _index,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.add_chart_sharp),
                  label: context.loc.dashboard),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.account_box_outlined),
                  label: context.loc.users),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.iconsSignal,
                    width: 24,
                    height: 24,
                    color: _index == 2
                        ? context.theme.colorScheme.primary
                        : context.theme.colorScheme.onBackground,
                  ),
                  label: context.loc.signals),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.area_chart), label: context.loc.chart),
            ],
          )),
    );
  }
}
