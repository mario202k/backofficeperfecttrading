import 'package:intl/intl.dart';

extension DateFormats on DateTime {
  String format({String languageCode = 'fr'}) {
    final formatter = DateFormat.yMMMMd(languageCode);

    final hour = DateFormat.Hm(languageCode);

    return "${formatter.format(this)} - ${hour.format(this)}";
  }

  String formatYMD({String languageCode = 'fr'}) {
    final formatter = DateFormat.yMMMd(languageCode);

    final hour = DateFormat.Hm(languageCode);

    return "${formatter.format(this)} - ${hour.format(this)}";
  }
}
