import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/addons/utilities/utilities.dart';
import 'package:widgetbook/src/addons/widgets/addon_option_list.dart';
import 'package:widgetbook/src/navigation/router.dart';
import 'package:widgetbook/widgetbook.dart';

abstract class ThemeAddon<T> extends WidgetbookAddOn {
  ThemeAddon({
    required ThemeSetting<T> setting,
  }) : super(
          icon: const Icon(Icons.theater_comedy),
          name: 'themes',
          wrapperBuilder: (context, routerData, child) => _wrapperBuilder<T>(
            context,
            child,
            routerData,
            setting,
          ),
          builder: (context) => _builder<T>(context),
          providerBuilder: (
            context,
          ) =>
              _providerBuilder<T>(context),
          getQueryParameter: (context) => _getQueryParameter<T>(context),
        );
}

Map<String, dynamic> _getQueryParameter<T>(BuildContext context) {
  final selectedItem =
      context.read<ThemeSettingProvider<T>>().value.activeTheme;

  return <String, dynamic>{
    'theme': selectedItem.name,
  };
}

Widget _builder<T>(BuildContext context) {
  final data = context.watch<ThemeSettingProvider<T>>().value;
  final themes = data.themes;
  final activeTheme = data.activeTheme;

  return AddonOptionList<WidgetbookTheme<T>>(
    name: 'Themes',
    options: themes,
    selectedOption: activeTheme,
    builder: (item) => Text(item.name),
    onTap: (item) {
      context.read<ThemeSettingProvider<T>>().tapped(item);
      context.read<AddOnProvider>().update();
      navigate(context);
    },
  );
}

Widget _wrapperBuilder<T>(
  BuildContext context,
  Widget child,
  Map<String, dynamic> routerData,
  ThemeSetting<T> data,
) {
  final activeThemeStringData = routerData['themes'] as String?;

  final activeThemeString = activeThemeStringData != null
      ? context.jsonToString(
          data: activeThemeStringData,
          addonItem: 'theme',
        )
      : null;

  WidgetbookTheme<T>? selectedTheme;

  if (activeThemeString != null) {
    final activeThemes = activeThemeString.split(',');
    final mapThemes = {for (var e in data.themes) e.name: e};

    for (final activeTheme in activeThemes) {
      if (mapThemes.containsKey(activeTheme)) {
        selectedTheme = mapThemes[activeTheme];
      }
    }
  }

  final initialData =
      selectedTheme != null ? data.copyWith(activeTheme: selectedTheme) : data;

  return ChangeNotifierProvider(
    create: (_) => ThemeSettingProvider<T>(
      initialData,
    ),
    child: child,
  );
}

SingleChildWidget _providerBuilder<T>(
  BuildContext context,
) {
  final selection = context.watch<ThemeSettingProvider<T>>().value;
  final theme = selection.activeTheme;

  return ChangeNotifierProvider(
    key: ValueKey(theme),
    create: (_) => ThemeProvider(theme),
  );
}
