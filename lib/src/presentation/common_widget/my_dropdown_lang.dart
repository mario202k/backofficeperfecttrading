import 'package:backoffice/src/themes/theme_data_build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../login/language_controller.dart';

class MyDropdownLang extends ConsumerWidget {
  final bool forDrawer;

  const MyDropdownLang({
    required this.forDrawer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<Locale>(
      items: AppLocalizations.supportedLocales
          .map((locale) => DropdownMenuItem(
              value: locale,
              child: Text(
                locale.languageCode.toUpperCase(),
                style: context.theme.textTheme.bodyText1!
                    .copyWith(color: forDrawer?Colors.black:Colors.white),
              )))
          .toList(),
      value: ref.watch(languageProvider),
      dropdownColor: forDrawer?Colors.white:Colors.black,
      iconEnabledColor: Colors.white,
      onChanged: (locale) async {
        if (locale != null) {
          ref.read(languageProvider.notifier).setLanguage(locale);
        }
      },
    );
  }
}
