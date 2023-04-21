import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook_core/widgetbook_core.dart';

@anno.WidgetbookApp.material(
  devices: [
    Apple.iPhone11,
    Apple.iPhone12,
    Apple.iPhone13,
  ],
  textScaleFactors: [
    1,
    2,
  ],
)
const int notUsed = 0;

@anno.WidgetbookTheme(name: 'Dark', isDefault: true)
ThemeData themeDark() => Themes.dark;

@anno.WidgetbookTheme(
  name: 'Light',
)
ThemeData themeLight() => Themes.light;
