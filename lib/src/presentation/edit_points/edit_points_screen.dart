import 'package:backoffice/src/constants/app_sizes.dart';
import 'package:backoffice/src/domain/data_fl_chart.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/graph_service.dart';
import '../../domain/point.dart';
import '../common_widget/loading.dart';
import '../common_widget/text_form_field_widget.dart';

class EditPointScreen extends ConsumerStatefulWidget {
  final DataFlChart dataFlChart;

  const EditPointScreen({required this.dataFlChart, Key? key})
      : super(key: key);

  @override
  ConsumerState<EditPointScreen> createState() => _EditPointScreenState();
}

class _EditPointScreenState extends ConsumerState<EditPointScreen> {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
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
              Table(
                border: TableBorder.all(
                    width: 1, color: Colors.black.withOpacity(0.4)),
                children: [
                  const TableRow(children: [
                    Text('x name'),
                    Text("x value"),
                    Text("y name"),
                    Text("y value"),
                    Text("update"),
                  ]),
                  ...widget.dataFlChart.points.map((point) {
                    String xName = point.x.key;
                    String yName = point.y.key;
                    String xValue = point.x.value.toString();
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
                          typeOfTextForm: TypeOfTextForm.number,
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
                          typeOfTextForm: TypeOfTextForm.number,
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
                          typeOfTextForm: TypeOfTextForm.number,
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
                          typeOfTextForm: TypeOfTextForm.number,
                        ),
                      ),
                      _isLoading
                          ? const Loading()
                          : ElevatedButton(
                              key: ValueKey(point.id),
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                final result = await ref
                                    .read(graphServiceProvider)
                                    .setPoint(
                                        graphId: widget.dataFlChart.graph.id,
                                        point: Point(
                                            x: MapEntry(
                                                xName, num.parse(xValue)),
                                            y: MapEntry(
                                                yName, num.parse(yValue)),
                                            id: point.id,
                                            createdAt: point.createdAt,
                                            updatedAt: DateTime.now()));
                                setState(() {
                                  _isLoading = false;
                                });
                                result.when(
                                    (success) =>
                                        context.showSnackBar("Point Updated"
                                            ""),
                                    (error) => context.showSnackBarError(
                                        error.details.message));
                              },
                              child: const Text('Update')),
                    ]
                            .map((e) =>
                                FittedBox(fit: BoxFit.scaleDown, child: e))
                            .toList());
                  })
                ],
              ),
              gapH64,
            ],
          ),
        ),
      ),
    );
  }
}
