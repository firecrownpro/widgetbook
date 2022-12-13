// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeviceSetting {
  List<Device> get devices => throw _privateConstructorUsedError;
  Device get activeDevice => throw _privateConstructorUsedError;
  Orientation get orientation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceSettingCopyWith<DeviceSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceSettingCopyWith<$Res> {
  factory $DeviceSettingCopyWith(
          DeviceSetting value, $Res Function(DeviceSetting) then) =
      _$DeviceSettingCopyWithImpl<$Res>;
  $Res call(
      {List<Device> devices, Device activeDevice, Orientation orientation});

  $DeviceCopyWith<$Res> get activeDevice;
}

/// @nodoc
class _$DeviceSettingCopyWithImpl<$Res>
    implements $DeviceSettingCopyWith<$Res> {
  _$DeviceSettingCopyWithImpl(this._value, this._then);

  final DeviceSetting _value;
  // ignore: unused_field
  final $Res Function(DeviceSetting) _then;

  @override
  $Res call({
    Object? devices = freezed,
    Object? activeDevice = freezed,
    Object? orientation = freezed,
  }) {
    return _then(_value.copyWith(
      devices: devices == freezed
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<Device>,
      activeDevice: activeDevice == freezed
          ? _value.activeDevice
          : activeDevice // ignore: cast_nullable_to_non_nullable
              as Device,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
    ));
  }

  @override
  $DeviceCopyWith<$Res> get activeDevice {
    return $DeviceCopyWith<$Res>(_value.activeDevice, (value) {
      return _then(_value.copyWith(activeDevice: value));
    });
  }
}

/// @nodoc
abstract class _$$_DeviceSettingCopyWith<$Res>
    implements $DeviceSettingCopyWith<$Res> {
  factory _$$_DeviceSettingCopyWith(
          _$_DeviceSetting value, $Res Function(_$_DeviceSetting) then) =
      __$$_DeviceSettingCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Device> devices, Device activeDevice, Orientation orientation});

  @override
  $DeviceCopyWith<$Res> get activeDevice;
}

/// @nodoc
class __$$_DeviceSettingCopyWithImpl<$Res>
    extends _$DeviceSettingCopyWithImpl<$Res>
    implements _$$_DeviceSettingCopyWith<$Res> {
  __$$_DeviceSettingCopyWithImpl(
      _$_DeviceSetting _value, $Res Function(_$_DeviceSetting) _then)
      : super(_value, (v) => _then(v as _$_DeviceSetting));

  @override
  _$_DeviceSetting get _value => super._value as _$_DeviceSetting;

  @override
  $Res call({
    Object? devices = freezed,
    Object? activeDevice = freezed,
    Object? orientation = freezed,
  }) {
    return _then(_$_DeviceSetting(
      devices: devices == freezed
          ? _value._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<Device>,
      activeDevice: activeDevice == freezed
          ? _value.activeDevice
          : activeDevice // ignore: cast_nullable_to_non_nullable
              as Device,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
    ));
  }
}

/// @nodoc

class _$_DeviceSetting implements _DeviceSetting {
  _$_DeviceSetting(
      {required final List<Device> devices,
      required this.activeDevice,
      this.orientation = Orientation.portrait})
      : _devices = devices;

  final List<Device> _devices;
  @override
  List<Device> get devices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  final Device activeDevice;
  @override
  @JsonKey()
  final Orientation orientation;

  @override
  String toString() {
    return 'DeviceSetting(devices: $devices, activeDevice: $activeDevice, orientation: $orientation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceSetting &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            const DeepCollectionEquality()
                .equals(other.activeDevice, activeDevice) &&
            const DeepCollectionEquality()
                .equals(other.orientation, orientation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_devices),
      const DeepCollectionEquality().hash(activeDevice),
      const DeepCollectionEquality().hash(orientation));

  @JsonKey(ignore: true)
  @override
  _$$_DeviceSettingCopyWith<_$_DeviceSetting> get copyWith =>
      __$$_DeviceSettingCopyWithImpl<_$_DeviceSetting>(this, _$identity);
}

abstract class _DeviceSetting implements DeviceSetting {
  factory _DeviceSetting(
      {required final List<Device> devices,
      required final Device activeDevice,
      final Orientation orientation}) = _$_DeviceSetting;

  @override
  List<Device> get devices;
  @override
  Device get activeDevice;
  @override
  Orientation get orientation;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceSettingCopyWith<_$_DeviceSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
