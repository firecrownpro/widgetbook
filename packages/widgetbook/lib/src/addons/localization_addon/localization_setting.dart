import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'localization_setting.freezed.dart';

@freezed
class LocalizationSetting extends WidgetbookAddOnModel
    with _$LocalizationSetting {
  @Assert('locales.isNotEmpty', 'locales cannot be empty')
  factory LocalizationSetting({
    required Locale activeLocale,
    required List<Locale> locales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) = _LocalizationSetting;

  /// Sets the first locale within `locales` as the active locale on
  /// startup
  factory LocalizationSetting.firstAsSelected({
    required List<Locale> locales,
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
  }) {
    assert(
      locales.isNotEmpty,
      'Please specify at least one supported $Locale.',
    );

    return LocalizationSetting(
      activeLocale: locales.first,
      locales: locales,
      localizationsDelegates: localizationsDelegates,
    );
  }

  const LocalizationSetting._();

  @override
  Map<String, String> toQueryParameter() {
    return {
      'locale': activeLocale.toString(),
    };
  }
}
