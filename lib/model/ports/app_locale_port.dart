import 'package:turskyi/res/language.dart';

abstract interface class AppLocalePort {
  Language get currentLanguage;

  void applyLanguage(Language language);
}
