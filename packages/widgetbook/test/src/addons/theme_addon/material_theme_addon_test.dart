import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import 'helper.dart';

void main() {
  group(
    '$MaterialThemeAddon',
    () {
      final blueTheme = ThemeData(
        primaryColor: colorBlue,
      );

      final yellowTheme = ThemeData(
        primaryColor: colorYellow,
      );

      final blueWidgetbookTheme = WidgetbookTheme(
        name: 'Blue',
        data: blueTheme,
      );

      final yellowWidgetbookTheme = WidgetbookTheme(
        name: 'Yellow',
        data: yellowTheme,
      );

      final addon = MaterialThemeAddon(
        themes: [blueWidgetbookTheme, yellowWidgetbookTheme],
      );

      testWidgets(
        'can activate a theme',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: () async => addon.updateSetting(
              addon.setting.copyWith(
                activeTheme: yellowWidgetbookTheme,
              ),
            ),
            expect: (context) => expect(
              addon.setting.activeTheme.data,
              equals(yellowWidgetbookTheme.data),
            ),
          );
        },
      );

      testWidgets(
        'can activate theme via Widget',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(
                DropdownMenu<WidgetbookTheme<ThemeData>>,
              );
              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == 'Yellow',
              );
              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (context) => expect(
              addon.setting.activeTheme.data,
              equals(yellowWidgetbookTheme.data),
            ),
          );
        },
      );
    },
  );
}