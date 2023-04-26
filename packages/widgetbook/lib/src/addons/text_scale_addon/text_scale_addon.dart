import 'package:flutter/material.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_setting.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

class TextScaleAddon extends WidgetbookAddOn<TextScaleSetting> {
  TextScaleAddon({
    required List<double> scales,
    double? initialScale,
  })  : assert(
          scales.isNotEmpty,
          'scales cannot be empty',
        ),
        assert(
          initialScale == null || scales.contains(initialScale),
          'initialScale must be in scales',
        ),
        super(
          initialSetting: TextScaleSetting(
            textScales: scales,
            activeTextScale: initialScale ?? scales.first,
          ),
        );

  @override
  Widget buildSetting(BuildContext context) {
    return Setting(
      name: 'Text scale',
      child: DropdownSetting<double>(
        options: initialSetting.textScales,
        initialSelection: initialSetting.activeTextScale,
        optionValueBuilder: (scale) => scale.toStringAsFixed(2),
        onSelected: (scale) {
          onChanged(
            setting.copyWith(
              activeTextScale: scale,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: setting.activeTextScale,
      ),
      child: child,
    );
  }
}

extension TextScaleExtension on BuildContext {
  /// Creates adjustable parameters for the WidgetbookUseCase
  double? get textScale => getAddonValue<TextScaleSetting>()?.activeTextScale;
}
