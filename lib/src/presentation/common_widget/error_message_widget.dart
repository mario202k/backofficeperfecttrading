import 'package:flutter/material.dart';

import '../../exceptions/app_exception.dart';

class ErrorMessageWidget extends StatelessWidget {
  final Object errorMessage;

  const ErrorMessageWidget(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage is AppException
          ? (errorMessage as AppException).details.message
          : errorMessage.toString(),
      style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
    );
  }
}
