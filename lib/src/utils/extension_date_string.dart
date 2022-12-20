import 'package:intl/intl.dart';

extension DateFormats on DateTime {
  String format(String languageCode, String countryCode) {
    final formatter = DateFormat.yMMMMd(languageCode);

    final hour = DateFormat.Hm(languageCode);

    return "${formatter.format(this)} - ${hour.format(this)}";
  }
}