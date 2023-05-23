import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@UseCase(
  name: 'default',
  type: KnobProperty,
)
Widget knobPropertyUseCase(BuildContext context) {
  return KnobProperty(
    name: context.knobs.string(
      label: 'Name',
      initialValue: 'Knob',
    ),
    value: true,
    description: context.knobs.stringOrNull(
      label: 'Description',
    ),
    isNullable: context.knobs.boolean(
      label: 'Is Nullable',
    ),
    child: const Placeholder(),
  );
}
