import 'package:flutter/cupertino.dart';

import 'theme_addon.dart';

/// A [ThemeAddon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required super.themes,
    super.initialTheme,
  }) : super(
          themeBuilder: (context, theme, child) {
            return CupertinoTheme(
              data: theme,
              child: ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: child,
              ),
            );
          },
        );
}
