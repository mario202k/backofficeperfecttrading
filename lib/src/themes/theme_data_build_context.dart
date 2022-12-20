import 'package:flutter/material.dart';

extension ThemeDataBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}
