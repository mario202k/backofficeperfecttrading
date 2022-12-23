import 'package:backoffice/src/application/graph_service.dart';
import 'package:backoffice/src/constants/app_sizes.dart';
import 'package:backoffice/src/presentation/common_widget/async_value_widget.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/routing/app_router.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/data_fl_chart.dart';

final getGraphsProvider =
    FutureProvider.autoDispose<List<DataFlChart>>((ref) async {
  return ref.watch(graphServiceProvider).getGraphs();
});

class GraphPage extends ConsumerWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsivePaddingCenter(
      child: SingleChildScrollView(
        child: Column(
          children: [
            gapH16,
            Text("Graph Page", style: context.theme.textTheme.headline5),
            // gapH16,
            // TextButton(
            //     onPressed: () async {
            //
            //       // final flChart =
            //       //     await ref.read(graphServiceProvider).getGraphs();
            //       // print(flChart.first);
            //
            //       // final graphId =
            //       //     FirestoreService.instance.getDocId(path: Paths.graphs());
            //       // ref.read(graphServiceProvider).setGraph(
            //       //     graph: Graph(
            //       //         id: graphId,
            //       //         type: GraphType.monthly,
            //       //         horizontalInterval: 200,
            //       //         verticalInterval: 1,
            //       //         createdAt: DateTime.now(),
            //       //         updatedAt: DateTime.now()),
            //       //     points: [
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Dec21",0),
            //       //           y: const MapEntry<String,num>("450",450),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Jan22",1),
            //       //           y: const MapEntry<String,num>("900",900),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Fev",2),
            //       //           y: const MapEntry<String,num>("1500",1500),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Mar",3),
            //       //           y: const MapEntry<String,num>("2000",2000),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Avr",4),
            //       //           y: const MapEntry<String,num>("1500",1500),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Mai",5),
            //       //           y: const MapEntry<String,num>("1200",1200),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("jui",6),
            //       //           y: const MapEntry<String,num>("900",900),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Juil",7),
            //       //           y: const MapEntry<String,num>("1500",1500),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Aoû",8),
            //       //           y: const MapEntry<String,num>("1400",1400),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Sep",9),
            //       //           y: const MapEntry<String,num>("2200",2200),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Oct",10),
            //       //           y: const MapEntry<String,num>("2200",2200),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //       Point(
            //       //           id: FirestoreService.instance
            //       //               .getDocId(path: Paths.points(graphId: graphId)),
            //       //           x: const MapEntry<String,num>("Nov",11),
            //       //           y: const MapEntry<String,num>("1700",1700),
            //       //           createdAt: DateTime.now(),
            //       //           updatedAt: DateTime.now()),
            //       //     ]);
            //     },
            //     child: const Text("Edit Points")),
            gapH16,
            AsyncValueWidget(
                value: ref.watch(getGraphsProvider),
                data: (data) {
                  return Column(
                    children: [
                      for (final graph in data)
                        Column(
                          children: [
                            gapH16,
                            TextButton(
                                onPressed: () {
                                  context.goNamed(AppRoute.editPoints.name,
                                      extra: graph);
                                },
                                child: const Text("Edit Graph")),
                            gapH16,
                            AspectRatio(
                              aspectRatio: 1.70,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 18,
                                  left: 12,
                                  top: 24,
                                  bottom: 12,
                                ),
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      horizontalInterval:
                                          graph.horizontalInterval,
                                      verticalInterval: graph.verticalInterval,
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          interval: 1,
                                          getTitlesWidget:
                                              graph.bottomTitleWidgets,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 200,
                                          getTitlesWidget:
                                              graph.leftTitleWidgets,
                                          reservedSize: 42,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      // border: Border.all(color: const Color(0xff37434d)),
                                    ),
                                    minX: graph.minX,
                                    maxX: graph.maxX,
                                    minY: graph.minY,
                                    maxY: graph.maxY,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: graph.spots,

                                        isCurved: true,
                                        // gradient: LinearGradient(
                                        //   colors: gradientColors,
                                        // ),
                                        color: const Color(0xff54FFBD),

                                        barWidth: 2,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter:
                                              (spot, percent, barData, index) =>
                                                  FlDotCirclePainter(
                                            radius: 2,
                                            color: Colors.white,
                                            strokeWidth: 1,
                                            strokeColor:
                                                const Color(0xff54FFBD),
                                          ),
                                        ),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: RadialGradient(
                                            radius: 5,
                                            center: Alignment.centerLeft,
                                            colors: [
                                              const Color(0xffFDD888),
                                              const Color(0xffDA2F47),
                                              const Color(0xff6246DC),
                                            ]
                                                .map((color) =>
                                                    color.withOpacity(0.2))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
