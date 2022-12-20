import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../presentation/login/language_controller.dart';

final currencyFormatterProvider = Provider.autoDispose<NumberFormat>((ref) {
  /// Currency formatter to be used in the app.
  /// * en_US is hardcoded to ensure all prices show with a dollar sign ($)
  /// * This may or may not be what you want in your own apps.
  final local = ref.watch(languageProvider);
  switch(local.languageCode){
    case "fr":
      return NumberFormat.simpleCurrency(locale: "fr_FR");
    case "en":
      return NumberFormat.simpleCurrency(locale: "en_US");
    default:
      return NumberFormat.simpleCurrency(locale: "fr_FR");
  }

});

Future<void> myLaunchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(
    uri,
  )) {
    throw 'Could not launch $url';
  }
  return;
}

double toEuroDiscountPrice({required double price, required int percentOff}) {

  return price * (100/(100 - percentOff));

  // return "${amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2)} €";
}