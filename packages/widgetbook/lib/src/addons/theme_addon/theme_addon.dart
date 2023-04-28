import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

typedef ThemeBuilder<T> = Widget Function(
  BuildContext context,
  T theme,
  Widget child,
);

class ThemeAddon<T> extends WidgetbookAddOn<ThemeSetting<T>> {
  ThemeAddon({
    required List<WidgetbookTheme<T>> themes,
    WidgetbookTheme<T>? initialTheme,
    required this.themeBuilder,
  })  : assert(
          themes.isNotEmpty,
          'themes cannot be empty',
        ),
        assert(
          initialTheme == null || themes.contains(initialTheme),
          'initialTheme must be in themes',
        ),
        super(
          initialSetting: ThemeSetting(
            themes: themes,
            activeTheme: initialTheme ?? themes.first,
          ),
        );

  final ThemeBuilder<T> themeBuilder;

  @override
  Widget buildSetting(
    BuildContext context,
    ThemeSetting<T> setting,
  ) {
    return Setting(
      name: 'Theme',
      child: DropdownSetting<WidgetbookTheme<T>>(
        options: setting.themes,
        initialSelection: setting.activeTheme,
        optionValueBuilder: (theme) => theme.name,
        onSelected: (theme) {
          onChanged(
            setting.copyWith(
              activeTheme: theme,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    ThemeSetting<T> setting,
    Widget child,
  ) {
    return themeBuilder(
      context,
      setting.activeTheme.data,
      child,
    );
  }
}
