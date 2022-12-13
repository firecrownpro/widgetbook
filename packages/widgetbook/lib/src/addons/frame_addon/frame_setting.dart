import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widgetbook/src/addons/addons.dart';

part 'frame_setting.freezed.dart';

@freezed
class FrameSetting with _$FrameSetting {
  factory FrameSetting({
    required List<Frame> frames,
    required Frame activeFrame,
  }) = _FrameSetting;

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory FrameSetting.firstAsSelected({
    required List<Frame> frames,
  }) {
    return FrameSetting(
      activeFrame: frames.first,
      frames: frames,
    );
  }
}
