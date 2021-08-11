/// [Language] is an enum object to contain all supported languages by project
enum Language {
  /// [en] is a country code enum value for English language
  en
}

/// [LanguageExtension] is an extension for enum object [Language] to provide
/// text [String] resource by enum value
extension LanguageExtension on Language {
  /// [code] is a variable containing [String] value depending on provided
  /// [Language] enum parameter
  String get code {
    switch (this) {
      case Language.en:
        return 'en';
    }
  }
}