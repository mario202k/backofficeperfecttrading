import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myValueProvider = StateProvider.autoDispose<MyDropdownValueEnum>((ref) {
  return MyDropdownValueEnum.all;
});

enum MyDropdownValueEnum { all, premium, deleted, online, logged }

class MyDropdownValue extends ConsumerWidget {
  const MyDropdownValue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<MyDropdownValueEnum>(
      items: MyDropdownValueEnum.values
          .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value.name,
                style: context.theme.textTheme.bodyText1,
              )))
          .toList(),
      value: ref.watch(myValueProvider),
      onChanged: (value) async {
        if (value != null) {
          ref.read(myValueProvider.notifier).state = value;
        }
      },
    );
  }
}
