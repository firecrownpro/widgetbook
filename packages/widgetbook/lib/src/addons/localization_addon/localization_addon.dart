import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class LocalizationAddon extends WidgetbookAddOn<LocalizationSetting> {
  LocalizationAddon({
    required List<Locale> locales,
    required List<LocalizationsDelegate> localizationsDelegates,
    Locale? initialLocale,
  })  : assert(
          locales.isNotEmpty,
          'locales cannot be empty',
        ),
        assert(
          initialLocale == null || locales.contains(initialLocale),
          'initialLocale must be in locales',
        ),
        super(
          initialSetting: LocalizationSetting(
            locales: locales,
            localizationsDelegates: localizationsDelegates,
            activeLocale: initialLocale ?? locales.first,
          ),
        );

  @override
  Widget buildSetting(
    BuildContext context,
    LocalizationSetting setting,
  ) {
    return Setting(
      name: 'Locale',
      child: DropdownSetting<Locale>(
        options: initialSetting.locales,
        initialSelection: initialSetting.activeLocale,
        optionValueBuilder: (locale) => locale.toString(),
        onSelected: (locale) {
          onChanged(
            setting.copyWith(
              activeLocale: locale,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    LocalizationSetting setting,
    Widget child,
  ) {
    return Localizations(
      locale: setting.activeLocale,
      delegates: setting.localizationsDelegates,
      child: child,
    );
  }
}
