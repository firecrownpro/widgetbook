import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/number_knob.dart';
import 'package:widgetbook/widgetbook.dart';

import 'knob_helper.dart';

void main() {
  testWidgets(
    'Equality operator works correctly',
    (WidgetTester tester) async {
      final first = NumberKnob(label: 'first', value: 2);
      final second = NumberKnob(label: 'second', value: 3);

      expect(first, equals(NumberKnob(label: 'first', value: 2)));
      expect(first, isNot(equals(second)));
    },
  );

  testWidgets(
    'Number knob initial value works',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs
              .number(
                label: 'label',
                initialValue: 5,
              )
              .toString(),
        ),
      );

      expect(find.text('5.0'), findsWidgets);
    },
  );

  testWidgets(
    'Number knob description displays',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs
              .number(
                label: 'label',
                initialValue: 200,
                description: 'test description',
              )
              .toString(),
        ),
      );

      expect(find.text('200.0'), findsWidgets);
    },
  );

  testWidgets(
    'Number knob functions',
    (WidgetTester tester) async {
      await tester.pumpWithKnob(
        (context) => Text(
          context.knobs
              .number(
                label: 'label',
              )
              .toString(),
        ),
      );

      await tester.enterText(find.byType(TextField), '5.5');
      await tester.pumpAndSettle();

      expect(find.text('5.5'), findsWidgets);
    },
  );
}
