import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import 'text_form_field_widget.dart';

class TextFieldAndTitle extends StatelessWidget {
  final String title;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? confirmationPassword;
  final TextEditingController textEditingController;
  final String? initialContent;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TypeOfTextForm typeOfTextForm;
  final TextInputType? textInputType;
  final VoidCallback? onEditingComplete;
  final Function(String val)? onChanged;
  final FocusNode? focusNode;

  const TextFieldAndTitle({
    Key? key,
    required this.title,
    this.hintText,
    this.confirmationPassword,
    required this.textEditingController,
    required this.typeOfTextForm,
    this.onEditingComplete,
     this.textInputAction,
    this.focusNode, this.initialContent, this.onChanged, this.textInputType, this.enabled, this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.caption!.copyWith(
                fontWeight: FontWeight.bold, letterSpacing: 2.4, height: 0.5,color: theme.colorScheme.onBackground),
          ),
          gapH4,
          TextFormFieldWidget(
            focusNode: focusNode,
            enabled: enabled,
            textEditingController: textEditingController,
            confirmationPassword: confirmationPassword,
            initialContent: initialContent,
            maxLines: maxLines,
            hintText: hintText,
            typeOfTextForm: typeOfTextForm,
            onEditingComplete: () => onEditingComplete?.call(),
            onChanged: onChanged,
            textInputAction: textInputAction,
            textInputType: textInputType,
          ),
        ],
      ),
    );
  }
}
