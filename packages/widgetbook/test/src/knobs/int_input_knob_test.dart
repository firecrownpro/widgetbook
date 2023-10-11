import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$IntInputKnob',
    () {
      testWidgets(
        'given an initial value, '
        'then the value should be displayed',
        (tester) async {
          const value = 5;

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.int
                  .input(
                    label: 'IntKnob',
                    initialValue: value,
                  )
                  .toString(),
            ),
          );

          expect(find.textWidget('$value'), findsOneWidget);
        },
      );

      testWidgets(
        'when field is updated, '
        'then the value should be updated',
        (tester) async {
          const initialValue = 5;
          const updatedValue = 10;

          await tester.pumpKnob(
            (context) => Text(
              context.knobs.int
                  .input(
                    label: 'IntKnob',
                    initialValue: initialValue,
                  )
                  .toString(),
            ),
          );

          await tester.findAndEnter(
            find.byType(TextField),
            updatedValue.toString(),
          );

          expect(
            find.textWidget('${updatedValue}'),
            findsOneWidget,
          );
        },
      );
    },
  );

  group('${IntInputKnob.nullable}', () {
    test('IntKnob.nullable constructor sets correct values', () {
      final knob = IntInputKnob.nullable(
        label: 'Test Int',
        value: 5,
        description: 'A test int knob',
      );

      expect(knob.label, 'Test Int');
      expect(knob.value, 5);
      expect(knob.description, 'A test int knob');
    });

    test('IntKnob.nullable constructor handles null value', () {
      final knob = IntInputKnob.nullable(
        label: 'Test Int',
        value: null,
        description: 'A test int knob with null value',
      );

      expect(knob.label, 'Test Int');
      expect(knob.value, null);
      expect(knob.description, 'A test int knob with null value');
    });
  });

  group('$KnobsBuilder', () {
    int? mockOnKnobAdded<int>(Knob<int?> knob) => knob.value;
    final builder = KnobsBuilder(mockOnKnobAdded);

    test('intOrNull sets correct values', () {
      final intValue = builder.intOrNull.input(
        label: 'Test Int',
        initialValue: 10,
        description: 'A test int',
      );

      expect(intValue, 10);
    });

    test('intOrNull handles null initialValue', () {
      final intValue = builder.intOrNull.input(
        label: 'Test Int',
        description: 'A test int with null value',
      );

      expect(intValue, null);
    });
  });
}
