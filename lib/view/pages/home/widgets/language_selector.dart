import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    required this.currentLanguage,
    required this.onLanguageSelected,
    super.key,
  });

  final ValueChanged<Language> onLanguageSelected;
  final Language currentLanguage;

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    return Positioned(
      top: Dimens.indent24,
      left: Dimens.indent24,
      child: SafeArea(
        child: Material(
          color: Colors.grey.withAlpha(70),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isLarge ? Colors.white : Colors.transparent,
            ),
          ),
          child: PopupMenuButton<Language>(
            tooltip: translate('change_language'),
            color: Colors.grey.shade900,
            onSelected: (Language lang) {
              // Change locale used by flutter_translate.
              // flutter_translate accepts locale as string like 'en' or 'uk'.
              changeLocale(context, lang.isoLanguageCode)
              // The returned value is always `null`.
              .then((Object? _) {
                onLanguageSelected(lang);
              });
            },
            itemBuilder: (BuildContext _) {
              return Language.values.map((Language lang) {
                return PopupMenuItem<Language>(
                  value: lang,
                  child: Row(
                    children: <Widget>[
                      Text(lang.flag),
                      const SizedBox(width: 8),
                      Text(
                        lang.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                isLarge
                    ? '${currentLanguage.flag} ${currentLanguage.name}'
                    : currentLanguage.flag,
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
