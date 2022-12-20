import 'package:flutter/material.dart';
import 'package:backoffice/src/themes/theme_data_build_context.dart';

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
}
