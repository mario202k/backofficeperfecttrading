import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/presentation/home/signal_page/signal_add_page.dart';
import 'package:backoffice/src/presentation/home/signal_page/signal_list_page.dart';
import 'package:flutter/material.dart';

class SignalPage extends StatefulWidget {
  const SignalPage({Key? key}) : super(key: key);

  @override
  State<SignalPage> createState() => _SignalPageState();
}

class _SignalPageState extends State<SignalPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePaddingCenter(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: 'List',
              ),
              Tab(
                text: 'Add',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              SignalListPage(),
              SignalAddPage()
            ]),
          ),
        ],
      ),
    );
  }
}
