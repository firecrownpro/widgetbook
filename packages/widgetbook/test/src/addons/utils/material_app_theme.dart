import 'package:flutter/material.dart';
import 'package:widgetbook/src/builder/models/app_builder_function.dart';
import 'package:widgetbook/widgetbook.dart';

import 'custom_app_theme.dart';

ThemeData get bluetheme => ThemeData(
      primaryColor: colorBlue,
    );

ThemeData get yellowtheme => ThemeData(
      primaryColor: colorYellow,
    );

final blueMaterialWidgetbookTheme =
    WidgetbookTheme(name: 'Blue', data: bluetheme);

final yellowMaterialWidgetbookTheme =
    WidgetbookTheme(name: 'Yellow', data: yellowtheme);

final materialThemeSetting = MaterialThemeSetting.firstAsSelected(
  themes: [blueMaterialWidgetbookTheme, yellowMaterialWidgetbookTheme],
);

final materialThemeAddon = MaterialThemeAddon(
  themeSetting: materialThemeSetting,
);

AppBuilderFunction get materialAppBuilder =>
    (BuildContext context, Widget child) {
      final frameBuilder = context.frameBuilder;
      return frameBuilder.builder(
        context,
        MaterialApp(
          theme: context.materialTheme,
          debugShowCheckedModeBanner: false,
          home: child,
        ),
      );
    };
