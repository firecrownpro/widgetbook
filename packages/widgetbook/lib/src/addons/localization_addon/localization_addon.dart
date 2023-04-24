import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class LocalizationAddon extends WidgetbookAddOn<LocalizationSetting> {
  LocalizationAddon({
    required super.initialSetting,
  }) : super(
          name: 'localization',
        );

  @override
  Widget buildSetting(BuildContext context) {
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
  Widget buildUseCase(BuildContext context, Widget child) {
    return Localizations(
      locale: setting.activeLocale,
      delegates: setting.localizationsDelegates,
      child: child,
    );
  }
}

extension LocalizationExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  LocalizationSetting? get localization => getAddonValue<LocalizationSetting>();
}
