import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/knobs/knobs_notifier.dart';
import 'package:widgetbook/src/knobs/text_knob.dart';

import 'knob_helper.dart';

void main() {
  const textFinderKey = Key('multilineKnobKey');
  const initialTextValue = '''
// Headers
for (var level = 1; level <= 6; level++)
  AppHeaderBlot(
    level: level,
    child: defaultText,
  ),
''';

  group('$TextKnob', () {
    testWidgets(
      'is multiline',
      (WidgetTester tester) async {
        await tester.pumpWithKnob(
          (context) => Text(
            key: textFinderKey,
            context.knobs.text(
              label: 'label',
              initialValue: initialTextValue,
              maxLines: null,
            ),
          ),
        );

        final textFinder = find.byType(TextField);

        expect(textFinder, findsWidgets);

        final multilineText = textFinder.evaluate().first.widget as TextField;
        expect(multilineText.maxLines, null);
      },
    );

    testWidgets(
      'is not multiline',
      (WidgetTester tester) async {
        await tester.pumpWithKnob(
          (context) => Text(
            context.knobs.text(
              label: 'label',
              initialValue: initialTextValue,
            ),
          ),
        );

        final textFinder = find.byType(TextField);

        expect(textFinder, findsWidgets);

        final multilineText = textFinder.evaluate().first.widget as TextField;
        expect(multilineText.maxLines, 1);
      },
    );
  });
}
