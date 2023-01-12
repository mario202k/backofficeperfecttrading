import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';
const kDialogDefaultKey = Key('dialog-default-key');

extension ThemeDataBuildContext on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)..removeCurrentSnackBar()..showSnackBar(SnackBar(
      content: Text(
        message,
        style: theme.textTheme.bodyText1!
            .copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
      backgroundColor: theme.colorScheme.surfaceVariant,
    ));
  }
  void showSnackBarError(String message) {
    ScaffoldMessenger.of(this)..removeCurrentSnackBar()..showSnackBar(SnackBar(
      content: Text(
        message,
        style: theme.textTheme.bodyText1!
            .copyWith(color: theme.colorScheme.onError),
      ),
      backgroundColor: theme.colorScheme.error,
    ));
  }

  Future<bool?> showAlertDialog({
    required String title,
    String? content,
    String? cancelActionText,
    String defaultActionText = 'OK',
  }) async {
    if (kIsWeb || !Platform.isIOS) {
      return showDialog(
        context: this,
        barrierDismissible: cancelActionText != null,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: content != null ? Text(content) : null,
          actions: <Widget>[
            if (cancelActionText != null)
              TextButton(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            TextButton(
              key: kDialogDefaultKey,
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    }
    return showCupertinoDialog(
      context: this,
      barrierDismissible: cancelActionText != null,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            key: kDialogDefaultKey,
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
