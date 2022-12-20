import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../main.dart';

final languageProvider =
    StateNotifierProvider.autoDispose<LanguageController, Locale>((ref) {
  return LanguageController(
      flutterSecureStorage: ref.watch(flutterSecureStorageProvider));
});

class LanguageController extends StateNotifier<Locale> {
  final FlutterSecureStorage flutterSecureStorage;

  LanguageController({required this.flutterSecureStorage})
      : super(Locale(ui.window.locale.languageCode)) {
    init();
  }

  Future<void> init() async {
    final language = await flutterSecureStorage.read(key: 'lang');
    if (language != null) {
      switch (language) {
        case 'FR':
          state = const Locale(
            'fr',
          );

          break;
        case 'EN':
          state = const Locale(
            'en',
          );
          break;
      }
    } else {
      final lang =
          Locale(ui.window.locale.languageCode, ui.window.locale.countryCode);
      setLanguage(lang);
    }
  }

  Future<void> setLanguage(Locale locale) async {
    if (locale.languageCode == 'en') {
      flutterSecureStorage.write(key: 'lang', value: 'EN');
      state = const Locale(
        'en',
      );
    } else {
      flutterSecureStorage.write(key: 'lang', value: 'FR');
      state = const Locale(
        'fr',
      );
    }
  }
}
