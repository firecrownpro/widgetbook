import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../fields/fields.dart';

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
          name: 'Theme',
          initialSetting: ThemeSetting(
            themes: themes,
            activeTheme: initialTheme ?? themes.first,
          ),
        );

  final ThemeBuilder<T> themeBuilder;

  @override
  List<Field> get fields {
    return [
      DropdownField<WidgetbookTheme<T>>(
        group: slugName,
        name: 'name',
        values: setting.themes,
        labelBuilder: (theme) => theme.name,
        codec: FieldCodec(
          toParam: (theme) => theme.name,
          toValue: (param) => setting.themes.firstWhere(
            (theme) => theme.name == param,
            orElse: () => setting.activeTheme,
          ),
        ),
        onChanged: (theme) {
          if (theme == null) return;

          updateSetting(
            setting.copyWith(
              activeTheme: theme,
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return themeBuilder(
      context,
      setting.activeTheme.data,
      child,
    );
  }
}
