import 'package:backoffice/src/application/firestore_service.dart';
import 'package:backoffice/src/application/graph_service.dart';
import 'package:backoffice/src/data/paths.dart';
import 'package:backoffice/src/domain/testimony.dart';
import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:backoffice/src/presentation/common_widget/responsive_center.dart';
import 'package:backoffice/src/utils/extension_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../../constants/app_sizes.dart';
import '../common_widget/loading.dart';
import '../common_widget/text_field_and_title.dart';
import '../common_widget/text_form_field_widget.dart';

class UpdateOrAddTestimonyScreen extends ConsumerStatefulWidget {
  final Testimony? testimony;

  const UpdateOrAddTestimonyScreen({this.testimony, Key? key})
      : super(key: key);

  @override
  ConsumerState<UpdateOrAddTestimonyScreen> createState() =>
      _UpdateOrAddTestimonyState();
}

class _UpdateOrAddTestimonyState
    extends ConsumerState<UpdateOrAddTestimonyScreen> {
  late TextEditingController _nameController;
  late TextEditingController _contentController;
  late DateTime _date;
  late GlobalKey<FormState> _fKey;
  late FocusScopeNode _node;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _contentController = TextEditingController();
    _date = DateTime.now();
    _fKey = GlobalKey<FormState>();
    _node = FocusScopeNode();
    _isLoading = false;

    if (widget.testimony != null) {
      _nameController.text = widget.testimony!.name;
      _contentController.text = widget.testimony!.content;
      _date = widget.testimony!.date;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update or add testimony'),
      ),
      body: ResponsivePaddingCenter(
        child: Column(
          children: [
            gapH20,
            Row(
              children: [
                Text(
                  "Date du témoignage: ",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                gapW16,
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Center(
                    child: WebDatePicker(
                      initialDate: _date,
                      onChange: (value) {
                        if (value != null) {
                          _date = value;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            gapH20,
            Form(
              key: _fKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFieldAndTitle(
                      title: "Nom de l'auteur",
                      textEditingController: _nameController,
                      typeOfTextForm: TypeOfTextForm.name,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    gapH16,
                    TextFieldAndTitle(
                      title: "Contenu",
                      textEditingController: _contentController,
                      maxLines: 5,
                      typeOfTextForm: TypeOfTextForm.any,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    gapH16,
                  ],
                ),
              ),
            ),
            gapH20,
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
                          .read(graphServiceProvider)
                          .setTestimony(
                              testimony: Testimony(
                                  id: widget.testimony != null
                                      ? widget.testimony!.id
                                      : FirestoreService.instance
                                          .getDocId(path: Paths.testimonies()),
                                  name: _nameController.text.trim(),
                                  content: _contentController.text.trim(),
                                  date: _date,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now()));

                      setState(() {
                        _isLoading = false;
                      });
                      result.when((success) {
                        context.showAlertDialog(
                            title: "Success",
                            content: widget.testimony != null
                                ? "Testimony Updated"
                                : "Testimony Added");
                      },
                          (error) =>
                              context.showSnackBarError(error.details.message));
                    }
                  },
                  child: Text(widget.testimony != null ? "Update" : "Add")),
          ],
        ),
      ),
    );
  }
}
