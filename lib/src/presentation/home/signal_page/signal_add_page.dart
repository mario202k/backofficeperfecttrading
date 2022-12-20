import 'package:backoffice/src/application/firestore_service.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/my_dropdown/title_dropdown.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/signal_service.dart';
import '../../../constants/app_sizes.dart';
import '../../../data/paths.dart';
import '../../../domain/signal.dart';
import '../../common_widget/loading.dart';
import '../../common_widget/text_field_and_title.dart';
import '../../common_widget/text_form_field_widget.dart';

class SignalAddPage extends ConsumerStatefulWidget {
  const SignalAddPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _State();
}

class _State extends ConsumerState {
  late TextEditingController _nameController;
  late TextEditingController _entryController;
  late TextEditingController _stopLossController;
  late TextEditingController _takeProfitController;
  late GlobalKey<FormState> _fKey;
  late FocusScopeNode _node;
  late bool _isLoading;
  late bool _isBuy;
  late bool _isVip;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _entryController = TextEditingController();
    _stopLossController = TextEditingController();
    _takeProfitController = TextEditingController();
    _fKey = GlobalKey<FormState>();
    _node = FocusScopeNode();
    _isLoading = false;
    _isBuy = true;
    _isVip = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          gapH16,
          FocusScope(
            node: _node,
            child: Form(
              key: _fKey,
              child: Column(
                children: [
                  Text(
                    "Add Signal",
                    style: context.theme.textTheme.headline5,
                  ),
                  gapH16,
                  TextFieldAndTitle(
                    title: "Name",
                    hintText: "EUR/USD",
                    textEditingController: _nameController,
                    typeOfTextForm: TypeOfTextForm.any,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                  ),
                  gapH16,
                  TextFieldAndTitle(
                    title: "Entry",
                    textEditingController: _entryController,
                    typeOfTextForm: TypeOfTextForm.number,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                  ),
                  gapH16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Call",
                        style: context.theme.textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.4,
                            height: 0.5,
                            color: context.theme.colorScheme.onBackground),
                      ),
                      gapH4,
                      TitleDropdown(
                          initialValue: true,
                          dropdownList: const {
                            true: "Buy",
                            false: "Sell",
                          },
                          callBack: (value) {
                            _isBuy = value;
                          }),
                    ],
                  ),
                  gapH16,
                  TextFieldAndTitle(
                    title: "Stop Loss",
                    textEditingController: _stopLossController,
                    typeOfTextForm: TypeOfTextForm.number,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                  ),
                  gapH16,
                  TextFieldAndTitle(
                    title: "Take Profit",
                    textEditingController: _takeProfitController,
                    typeOfTextForm: TypeOfTextForm.number,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                  ),
                  gapH16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Send to :",
                        style: context.theme.textTheme.caption!.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.4,
                            height: 0.5,
                            color: context.theme.colorScheme.onBackground),
                      ),
                      gapH4,
                      TitleDropdown(
                          initialValue: true,
                          dropdownList: const {
                            true: "VIP members",
                            false: "Non-VIP members",
                          },
                          callBack: (value) {
                            _isVip = value;
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          gapH16,
          if (_isLoading)
            const Loading()
          else
            ElevatedButton(
                onPressed: () async {
                  if (_fKey.currentState!.validate()) {
                    _fKey.currentState!.save();
                    setState(() {
                      _isLoading = true;
                    });

                    final result =
                        await ref.read(signalServiceProvider).setSignal(
                              signal: Signal(
                                id: FirestoreService.instance
                                    .getDocId(path: Paths.signals()),
                                name: _nameController.text,
                                entry: num.parse(_entryController.text.trim()),
                                stopLoss: num.parse(_entryController.text.trim()),
                                updatedAt: DateTime.now(),
                                takeProfit:
                                    num.parse(_takeProfitController.text.trim()),
                                isBuy: _isBuy,
                                isVip: _isVip,
                                createdAt: DateTime.now(),
                                isClosed: false,
                              ),
                            );
                    setState(() {
                      _isLoading = false;
                    });
                    result.when((success) {
                      context.showSnackBar("Signal Added");
                      _nameController.clear();
                      _entryController.clear();
                      _stopLossController.clear();
                      _takeProfitController.clear();

                    },
                        (error) => context.showSnackBar(error.details.message));
                  }
                },
                child: const Text("Add"))
        ],
      ),
    );
  }
}
