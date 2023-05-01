import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

part 'text_scale_setting.freezed.dart';

@freezed
class TextScaleSetting extends WidgetbookAddOnModel<TextScaleSetting>
    with _$TextScaleSetting {
  factory TextScaleSetting({
    required double activeTextScale,
    required List<double> textScales,
  }) = _TextScaleSetting;

  TextScaleSetting._();

  @override
  Map<String, String> toMap() {
    return {
      'text-scale': activeTextScale.toStringAsFixed(2),
    };
  }

  @override
  TextScaleSetting fromMap(Map<String, String> map) {
    return this.copyWith(
      activeTextScale: textScales.firstWhere(
        (scale) => scale.toStringAsFixed(2) == map['text-scale'],
        orElse: () => activeTextScale,
      ),
    );
  }
}
