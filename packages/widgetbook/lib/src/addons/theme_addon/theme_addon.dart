import 'package:flutter/material.dart';
import 'package:widgetbook/src/routing/router.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

abstract class ThemeAddon<T> extends WidgetbookAddOn<ThemeSetting<T>> {
  ThemeAddon({
    required super.setting,
  }) : super(
          name: 'themes',
        );

  @override
  Widget build(BuildContext context) {
    final themes = value.themes;
    final activeTheme = value.activeTheme;

    return Setting(
      name: 'Theme',
      child: DropdownSetting<WidgetbookTheme<T>>(
        options: themes,
        initialSelection: activeTheme,
        optionValueBuilder: (theme) => theme.name,
        onSelected: (newActiveTheme) {
          onChanged(
            context,
            value.copyWith(activeTheme: newActiveTheme),
          );
        },
      ),
    );
  }

  @override
  void updateQueryParameters(BuildContext context, ThemeSetting<T> value) {
    context.goTo(queryParams: value.toQueryParameter());
  }

  @override
  ThemeSetting<T> settingFromQueryParameters({
    required Map<String, String> queryParameters,
    required ThemeSetting<T> setting,
  }) {
    final WidgetbookTheme<T>? activeTheme = parseQueryParameters(
      name: 'theme',
      queryParameters: queryParameters,
      mappedData: {for (var e in setting.themes) e.name: e},
    );

    return setting.copyWith(activeTheme: activeTheme);
  }
}
