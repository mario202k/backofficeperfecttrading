import 'package:backoffice/src/localization/localized_build_context.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.dart';
import '../../constants/reg_exp.dart';

enum TypeOfTextForm { password, name, email, any, number }

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool? enabled;
  final String? initialContent;
  final String? hintText;
  final int? maxLines;
  final TextEditingController? confirmationPassword;
  final TypeOfTextForm typeOfTextForm;
  final TextInputAction? textInputAction;
  final OutlineInputBorder? border;
  final TextInputType? textInputType;
  final VoidCallback? onEditingComplete;
  final Function(String val)? onChanged;
  final FocusNode? focusNode;

  const TextFormFieldWidget(
      {Key? key,
      required this.textEditingController,
      required this.typeOfTextForm,
      this.onEditingComplete,
      this.confirmationPassword,
      this.maxLines,
      this.hintText,
      this.textInputAction,
      this.focusNode,
      this.initialContent,
      this.onChanged,
      this.textInputType, this.enabled, this.border})
      : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    if (widget.initialContent != null) {
      widget.textEditingController.text = widget.initialContent!;
    }
    if (widget.typeOfTextForm == TypeOfTextForm.password) {
      obscureText = false;
    } else {
      obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: switchTypeOfTextForm(widget.typeOfTextForm),
      textInputAction: widget.textInputAction,
      onChanged: (val) {
        final onChanged = widget.onChanged;
        if (onChanged != null) {
          onChanged(val);
        }
      },
      decoration: InputDecoration(
        hintText: widget.typeOfTextForm == TypeOfTextForm.password
            ? " \u{2022}\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}\u{2022}"
            : widget.hintText,
        border: widget.border ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: context.theme.colorScheme.outline,
            width: 1,
          ),
        ),
        suffixIcon: widget.typeOfTextForm == TypeOfTextForm.password
            ? IconButton(
                onPressed: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                icon: obscureText
                    ? SvgPicture.asset(
                        Assets.iconsEyeClose,
                        color: Colors.black,
                        height: 18.0,
                        width: 18.0,
                      )
                    : SvgPicture.asset(
                        Assets.iconsEye,
                        color: Colors.black,
                        height: 18.0,
                        width: 18.0,
                      ),
              )
            : const SizedBox(),
      ),
      onEditingComplete: () => widget.onEditingComplete?.call(),
      obscureText:
          widget.typeOfTextForm == TypeOfTextForm.password && !obscureText,
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return context.loc.cannotBeEmpty;
        }
        val = val.trim();
        switch (widget.typeOfTextForm) {
          case TypeOfTextForm.password:
            final confirmationPassword = widget.confirmationPassword;

            if (confirmationPassword != null &&
                confirmationPassword.text !=
                    widget.textEditingController.text) {
              return context.loc.notTheSame;
            }

            if (RegExp(regExpMDP).allMatches(val).isEmpty) {
              return context.loc.oneUppercaseOneDigitAtLeast8Char;
            }
            break;
          case TypeOfTextForm.name:
            if (RegExp(regExpNom).allMatches(val).isEmpty) {
              return context.loc.inputError;
            }
            break;
          case TypeOfTextForm.email:
            if (RegExp(regExpEmail).allMatches(val).isEmpty) {
              return context.loc.inputError;
            }
            break;
          case TypeOfTextForm.any:
            break;
          case TypeOfTextForm.number:
            if (RegExp(regExpFloat).allMatches(val).isEmpty || val.contains(",")) {
              return context.loc.inputError;
            }

            break;
        }

        return null;
      },
    );
  }

  List<String> switchTypeOfTextForm(TypeOfTextForm typeOfTextForm) {
    switch (typeOfTextForm) {
      case TypeOfTextForm.password:
        return [AutofillHints.password];
      case TypeOfTextForm.name:
        return [AutofillHints.name];
      case TypeOfTextForm.email:
        return [AutofillHints.email];
      case TypeOfTextForm.any:
        return [];
      case TypeOfTextForm.number:
        return [];
    }
  }
}
