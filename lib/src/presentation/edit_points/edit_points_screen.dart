import 'package:backoffice/src/application/firestore_service.dart';
import 'package:backoffice/src/constants/app_sizes.dart';
import 'package:backoffice/src/data/paths.dart';
import 'package:backoffice/src/domain/data_fl_chart.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/async_value_widget.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/graph_service.dart';
import '../../domain/point.dart';
import '../common_widget/loading.dart';
import '../common_widget/text_field_and_title.dart';
import '../common_widget/text_form_field_widget.dart';

final getStreamPointProvider =
    StreamProvider.family.autoDispose<List<Point?>, String>((ref, graphId) {
  return ref.watch(graphServiceProvider).watchPoints(graphId: graphId);
});

class EditPointScreen extends ConsumerStatefulWidget {
  final DataFlChart dataFlChart;

  const EditPointScreen({required this.dataFlChart, Key? key})
      : super(key: key);

  @override
  ConsumerState<EditPointScreen> createState() => _EditPointScreenState();
}

class _EditPointScreenState extends ConsumerState<EditPointScreen> {
  late bool _isLoading;
  late TextEditingController _pipsWonController;
  late TextEditingController _tradesController;
  late bool _isLoadingPisWon;
  late bool _isLoadingTrades;
  late num _lastXPoint;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _pipsWonController = TextEditingController();
    _tradesController = TextEditingController();
    _isLoadingPisWon = false;
    _isLoadingTrades = false;
  }

  @override
  void dispose() {
    _pipsWonController.dispose();
    _tradesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Points'),
      ),
      body: ResponsivePaddingCenter(
        child: SingleChildScrollView(
          child: Column(
            children: [
              gapH16,
              Text(
                'Edit Points',
                style: Theme.of(context).textTheme.headline5,
              ),
              gapH16,
              AsyncValueWidget(
                  value: ref.watch(
                      getStreamPointProvider(widget.dataFlChart.graph.id)),
                  data: (data) {

                    if (data.isEmpty) {
                      return const Center(child: Text('No Points'));
                    }
                    data.sort((a, b) => a!.x.value.compareTo(b!.x.value));

                    _lastXPoint = data.last!.x.value;
                    return Table(
                      border: TableBorder.all(
                          width: 1, color: Colors.black.withOpacity(0.4)),
                      children: [
                        const TableRow(children: [
                          Text('x name'),
                          Text("x value"),
                          Text("y name"),
                          Text("y value"),
                          Text("update/delete"),
                        ]),
                        ...data.map((point) {
                          String xName = point!.x.key;
                          String xValue = point.x.value.toString();
                          String yName = point.y.key;
                          String yValue = point.y.value.toString();
                          return TableRow(
                              children: [
                            IntrinsicWidth(
                              child: TextFormFieldWidget(
                                onChanged: (value) {
                                  xName = value;
                                },
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                textEditingController:
                                    TextEditingController(text: xName),
                                typeOfTextForm: TypeOfTextForm.any,
                              ),
                            ),
                            IntrinsicWidth(
                              child: TextFormFieldWidget(
                                onChanged: (value) {
                                  xValue = value;
                                },
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                textEditingController:
                                    TextEditingController(text: xValue),
                                typeOfTextForm: TypeOfTextForm.any,
                              ),
                            ),
                            IntrinsicWidth(
                              child: TextFormFieldWidget(
                                onChanged: (value) {
                                  yName = value;
                                },
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                textEditingController:
                                    TextEditingController(text: yName),
                                typeOfTextForm: TypeOfTextForm.any,
                              ),
                            ),
                            IntrinsicWidth(
                              child: TextFormFieldWidget(
                                onChanged: (value) {
                                  yValue = value;
                                },
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                textEditingController:
                                    TextEditingController(text: yValue),
                                typeOfTextForm: TypeOfTextForm.any,
                              ),
                            ),
                            _isLoading
                                ? const Loading()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              _isLoading = true;
                                            });

                                            final myPoint = Point(
                                                x: MapEntry(xName,
                                                    num.parse(xValue)),
                                                y: MapEntry(yName,
                                                    num.parse(yValue)),
                                                id: point.id,
                                                createdAt:
                                                point.createdAt,
                                                updatedAt:
                                                DateTime.now());

                                            await ref.read(graphServiceProvider).deletePoint(graphId: widget
                                                .dataFlChart.graph.id,
                                                pointId: point.id);

                                            final result = await ref
                                                .read(graphServiceProvider)
                                                .setPoint(
                                                    graphId: widget
                                                        .dataFlChart.graph.id,
                                                    point: myPoint);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            result.when(
                                                (success) =>
                                                    context.showSnackBar(
                                                        "Point Updated"
                                                        ""),
                                                (error) =>
                                                    context.showSnackBarError(
                                                        error.details.message));
                                          },
                                          child: const Text('Update')),
                                      gapW2,
                                      ElevatedButton(
                                          onPressed: () async {
                                            final rep =
                                                await context.showAlertDialog(
                                                    title: "Are you sure?",
                                                    defaultActionText: "Delete",
                                                    cancelActionText: "Cancel");

                                            if (rep == null || !rep) return;

                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final result = await ref
                                                .read(graphServiceProvider)
                                                .deletePoint(
                                                    graphId: widget
                                                        .dataFlChart.graph.id,
                                                    pointId: point.id);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            result.when((success) {
                                              context.showAlertDialog(
                                                title: "Point Deleted",
                                                content:
                                                    "Point deleted successfully",
                                              );
                                              context
                                                  .showSnackBar("Point Updated"
                                                      "");
                                            },
                                                (error) =>
                                                    context.showSnackBarError(
                                                        error.details.message));
                                          },
                                          child: const Text('Delete')),
                                    ],
                                  ),
                          ]
                                  .map((e) => FittedBox(
                                      fit: BoxFit.scaleDown, child: e))
                                  .toList());
                        })
                      ],
                    );
                  }),
              gapH64,
              ElevatedButton(
                  onPressed: () {
                    ref.read(graphServiceProvider).setPoint(
                        graphId: widget.dataFlChart.graph.id,
                        point: Point(
                            x:  MapEntry('Jan', _lastXPoint+1),
                            y: const MapEntry('2000', 2000),
                            id: FirestoreService.instance.getDocId(
                                path: Paths.points(
                                    graphId: widget.dataFlChart.graph.id)),
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now()));
                  },
                  child: const Text('Add Point')),
              gapH64,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldAndTitle(
                    title: "Total pips gagnés",
                    textEditingController: _pipsWonController,
                    typeOfTextForm: TypeOfTextForm.number,
                    onEditingComplete: () async {
                      _updatePipsWon(context);
                    },
                  ),
                  gapH16,
                  _isLoadingPisWon
                      ? const Loading()
                      : ElevatedButton(
                          onPressed: () {
                            _updatePipsWon(context);
                          },
                          child: const Text("Update pips won")),
                ],
              ),
              gapH64,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldAndTitle(
                    title: "Total trades",
                    textEditingController: _tradesController,
                    typeOfTextForm: TypeOfTextForm.number,
                    onEditingComplete: () {
                      _updateTrades(context);
                    },
                  ),
                  gapH16,
                  _isLoadingTrades
                      ? const Loading()
                      : ElevatedButton(
                          onPressed: () {
                            _updateTrades(context);
                          },
                          child: const Text("Update Total trades")),
                ],
              ),
              gapH64,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updatePipsWon(BuildContext context) async {
    setState(() {
      _isLoadingPisWon = true;
    });
    final result = await ref.read(graphServiceProvider).updateGraph(
        entry: MapEntry<String, int>(
            "totalPipsWon", int.parse(_pipsWonController.text)),
        graphId: widget.dataFlChart.graph.id);
    setState(() {
      _isLoadingPisWon = false;
    });
    result.when(
        (success) =>
            context.showAlertDialog(title: "Total pips gagnés updated"),
        (error) => context.showSnackBarError(error.details.message));
  }

  Future<void> _updateTrades(BuildContext context) async {
    setState(() {
      _isLoadingTrades = true;
    });
    final result = await ref.read(graphServiceProvider).updateGraph(
        entry: MapEntry<String, int>(
            "totalTrades", int.parse(_tradesController.text)),
        graphId: widget.dataFlChart.graph.id);
    setState(() {
      _isLoadingTrades = false;
    });
    result.when(
        (success) => context.showAlertDialog(title: "Total trades updated"),
        (error) => context.showSnackBarError(error.details.message));
  }
}
