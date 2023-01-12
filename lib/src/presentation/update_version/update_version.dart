import 'package:backoffice/src/application/app_user_service.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_sizes.dart';
import '../../domain/app_version.dart';
import '../common_widget/loading.dart';
import '../common_widget/text_field_and_title.dart';
import '../common_widget/text_form_field_widget.dart';

class UpdateVersion extends ConsumerStatefulWidget {
  final AppVersion? appVersion;

  const UpdateVersion({
    this.appVersion,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UpdateVersionState();
}

class _UpdateVersionState extends ConsumerState<UpdateVersion> {
  late TextEditingController _versionController;
  late TextEditingController _appStoreUrlController;
  late TextEditingController _playStoreUrlController;
  late TextEditingController _whatsNewController;
  late GlobalKey<FormState> _fKey;
  late FocusScopeNode _node;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _versionController =
        TextEditingController(text: widget.appVersion?.version);
    _appStoreUrlController =
        TextEditingController(text: widget.appVersion?.appStoreUrl);
    _playStoreUrlController =
        TextEditingController(text: widget.appVersion?.playStoreUrl);
    _whatsNewController =
        TextEditingController(text: widget.appVersion?.whatsNew);
    _fKey = GlobalKey<FormState>();
    _node = FocusScopeNode();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Version'),
      ),
      body: ResponsivePaddingCenter(
        child: Form(
          key: _fKey,
          child: FocusScope(
            node: _node,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                gapH16,
                TextFieldAndTitle(
                  title: "Version",
                  hintText: "1.0.10",
                  textEditingController: _versionController,
                  typeOfTextForm: TypeOfTextForm.any,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                ),
                gapH16,
                TextFieldAndTitle(
                  title: "AppStore Url",
                  hintText:
                      "https://apps.apple.com/us/app/forex-signal-perfect-trading/id1645056463",
                  textEditingController: _appStoreUrlController,
                  typeOfTextForm: TypeOfTextForm.any,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                ),
                gapH16,
                TextFieldAndTitle(
                  title: "PlayStore Url",
                  hintText:
                      "https://play.google.com/store/apps/details?id=com.app.perfecttrading",
                  textEditingController: _playStoreUrlController,
                  typeOfTextForm: TypeOfTextForm.any,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                ),
                gapH16,
                TextFieldAndTitle(
                  title: "What's New",
                  hintText:
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum",
                  textEditingController: _whatsNewController,
                  typeOfTextForm: TypeOfTextForm.any,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                ),
                gapH16,
                _isLoading
                    ? const Loading()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_fKey.currentState!.validate()) {
                            _node.unfocus();
                            setState(() {
                              _isLoading = true;
                            });
                            final result = await ref
                                .read(appUserServiceProvider)
                                .setAppVersion(
                                  appVersion: AppVersion(
                                    version: _versionController.text,
                                    appStoreUrl: _appStoreUrlController.text,
                                    playStoreUrl: _playStoreUrlController.text,
                                    whatsNew: _whatsNewController.text,
                                    updatedAt: DateTime.now(),
                                    createdAt: DateTime.now(),
                                  ),
                                );
                            setState(() {
                              _isLoading = false;
                            });
                            result.when(
                                (success) =>
                                    context.showSnackBar("Successfully added"),
                                (error) => context
                                    .showSnackBarError(error.details.message));
                          }
                        },
                        child: const Text('Update'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
