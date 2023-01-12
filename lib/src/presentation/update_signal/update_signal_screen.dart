import 'package:backoffice/src/domain/signal.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/signal_service.dart';
import '../../constants/app_sizes.dart';
import '../common_widget/loading.dart';
import '../common_widget/my_dropdown/title_dropdown.dart';
import '../common_widget/text_field_and_title.dart';
import '../common_widget/text_form_field_widget.dart';

class UpdateSignalScreen extends ConsumerStatefulWidget {
  final Signal signal;

  const UpdateSignalScreen({Key? key, required this.signal}) : super(key: key);

  @override
  ConsumerState<UpdateSignalScreen> createState() => _UpdateSignalScreenState();
}

class _UpdateSignalScreenState extends ConsumerState<UpdateSignalScreen> {
  late TextEditingController _nameController;
  late TextEditingController _entryController;
  late TextEditingController _stopLossController;
  late TextEditingController _takeProfitController;
  late TextEditingController _pipsController;
  late GlobalKey<FormState> _fKey;
  late FocusScopeNode _node;
  late bool _isLoading;
  late bool _isBuy;
  late bool _isVip;
  late bool _isClosed;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _pipsController = TextEditingController();
    _entryController = TextEditingController();
    _stopLossController = TextEditingController();
    _takeProfitController = TextEditingController();
    _fKey = GlobalKey<FormState>();
    _node = FocusScopeNode();
    _isLoading = false;
    _isBuy = true;
    _isVip = true;

    _nameController.text = widget.signal.name;
    _entryController.text = widget.signal.entry.toString();
    _stopLossController.text = widget.signal.stopLoss.toString();
    _takeProfitController.text = widget.signal.takeProfit.toString();
    _pipsController.text = widget.signal.pips.toString();
    _isBuy = widget.signal.isBuy;
    _isVip = widget.signal.isVip;
    _isClosed = widget.signal.isClosed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Signal'),
      ),
      body: SingleChildScrollView(
        child: ResponsivePaddingCenter(
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
                        "Update Signal",
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
                              initialValue: _isBuy,
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
                      TextFieldAndTitle(
                        title: "Pips",
                        textEditingController: _pipsController,
                        typeOfTextForm: TypeOfTextForm.any,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                      ),
                      gapH16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Signal for:",
                            style: context.theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4,
                                height: 0.5,
                                color: context.theme.colorScheme.onBackground),
                          ),
                          gapH4,
                          TitleDropdown(
                              initialValue: _isVip,
                              dropdownList: const {
                                true: "VIP members",
                                false: "Non-VIP members",
                              },
                              callBack: (value) {
                                _isVip = value;
                              }),
                        ],
                      ),
                      gapH16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Is closed :",
                            style: context.theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4,
                                height: 0.5,
                                color: context.theme.colorScheme.onBackground),
                          ),
                          gapH4,
                          TitleDropdown(
                              initialValue: _isClosed,
                              dropdownList: const {
                                true: "Fermé",
                                false: "Ouvert",
                              },
                              callBack: (value) {
                                _isClosed = value;
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

                        final result = await ref
                            .read(signalServiceProvider)
                            .setSignal(
                              signal: Signal(
                                id: widget.signal.id,
                                name: _nameController.text,
                                entry: num.parse(_entryController.text.trim()),
                                stopLoss:
                                    num.parse(_stopLossController.text.trim()),
                                updatedAt: DateTime.now(),
                                pips: num.tryParse(_pipsController.text.trim())
                                    ?.toInt() ?? 0,
                                takeProfit: num.parse(
                                    _takeProfitController.text.trim()),
                                isBuy: _isBuy,
                                isVip: _isVip,
                                createdAt: DateTime.now(),
                                isClosed: _isClosed,
                              ),
                            );
                        setState(() {
                          _isLoading = false;
                        });
                        result.when((success) {
                          context.showSnackBar("Signal Updated");
                        },
                            (error) =>
                                context.showSnackBar(error.details.message));
                      }
                    },
                    child: const Text("Update")),
              gapH144,
            ],
          ),
        ),
      ),
    );
  }
}
