import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

class ZoomMode extends Mode<double> {
  ZoomMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  }
}

class ZoomAddon extends ModesAddon<ZoomMode> {
  ZoomAddon()
      : super(
          name: 'Zoom',
          modes: [],
        );

  @override
  List<Field> get fields {
    return [
      DoubleSliderField(
        name: 'ratio',
        initialValue: 1,
        min: 0.25,
        max: 4,
        divisions: 4 * 4 - 1,
      ),
    ];
  }

  @override
  ZoomMode valueFromQueryGroup(Map<String, String> group) {
    return ZoomMode(
      valueOf<double>('ratio', group)!,
    );
  }
}
