import 'package:backoffice/src/constants/app_sizes.dart';
import 'package:backoffice/src/domain/signal.dart';
import 'package:backoffice/src/presentation/common_widget/async_value_widget.dart';
import 'package:backoffice/src/routing/app_router.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/signal_repository.dart';

final allSignalsProvider =
    FutureProvider.autoDispose<List<Signal>>((ref) async {
  return ref.watch(signalRepositoryProvider).getSignals();
});

class SignalListPage extends ConsumerWidget {
  const SignalListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          gapH16,
           Text(
            'All Signals',
            style: context.theme.textTheme.headline5,
          ),
          gapH16,
          AsyncValueWidget(
              value: ref.watch(allSignalsProvider),
              data: (data) {
                return Table(
                  border: TableBorder.all(
                      width: 1, color: Colors.black.withOpacity(0.4)),
                  children: [
                    const TableRow(children: [
                      Text('Name'),
                      Text('Entry'),
                      Text('Take profit'),
                      Text('Stop loss'),
                      Text('Call'),
                      Text('Status'),
                      Text('Category'),
                      Text('Change'),
                    ]),
                    ...data.map((signal) => TableRow(
                            children: [
                          Text(signal.name),
                          Text(signal.entry.toString()),
                          Text(signal.takeProfit.toString()),
                          Text(signal.stopLoss.toString()),
                          Text(signal.isBuy ? 'Buy' : 'Sell'),
                          Text(signal.isClosed ? 'Closed' : 'Open'),
                          Text(signal.isVip ? 'VIP' : 'Non-VIP'),
                          ElevatedButton(
                              onPressed: () {
                                context.goNamed(AppRoute.updateSignal.name,
                                    extra: signal);
                              },
                              child: const Text('Update')),
                        ]
                                .map((e) =>
                                    FittedBox(fit: BoxFit.scaleDown, child: e))
                                .toList()))
                  ],
                );
              }),
        ],
      ),
    );
  }
}
