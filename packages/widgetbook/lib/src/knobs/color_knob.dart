import 'dart:ui';

import 'package:meta/meta.dart';

import '../fields/fields.dart';
import 'knob.dart';

@internal
class ColorKnob extends Knob<Color> {
  ColorKnob({
    required super.label,
    required super.initialValue,
    super.description,
    this.initialColorSpace = ColorSpace.hex,
  });

  ColorSpace initialColorSpace;

  @override
  List<Field> get fields {
    return [
      ColorField(
        name: label,
        initialValue: initialValue,
        initialColorSpace: initialColorSpace,
      ),
    ];
  }

  @override
  Color valueFromQueryGroup(Map<String, String> group) {
    return valueOf(label, group)!;
  }
}
