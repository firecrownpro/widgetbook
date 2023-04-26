import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomThemeAddon<T> extends ThemeAddon<T> {
  CustomThemeAddon({
    required List<WidgetbookTheme<T>> themes,
    required this.themeBuilder,
    WidgetbookTheme<T>? initialTheme,
  }) : super(
          themes: themes,
          initialTheme: initialTheme,
        );

  final Widget Function(T theme, Widget child) themeBuilder;

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return themeBuilder(
      initialSetting.activeTheme.data,
      child,
    );
  }
}

extension CustomThemeExtension on BuildContext {
  T? theme<T>() => getAddonValue<ThemeSetting<T>>()?.activeTheme.data;
}
