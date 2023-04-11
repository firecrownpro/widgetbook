// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_locales_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookLocalesData _$WidgetbookLocalesDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookLocalesData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookLocalesData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;
  List<String> get locales => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookLocalesDataCopyWith<WidgetbookLocalesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookLocalesDataCopyWith<$Res> {
  factory $WidgetbookLocalesDataCopyWith(WidgetbookLocalesData value,
          $Res Function(WidgetbookLocalesData) then) =
      _$WidgetbookLocalesDataCopyWithImpl<$Res, WidgetbookLocalesData>;
  @useResult
  $Res call(
      {String name,
      String importStatement,
      List<String> dependencies,
      List<String> locales});
}

/// @nodoc
class _$WidgetbookLocalesDataCopyWithImpl<$Res,
        $Val extends WidgetbookLocalesData>
    implements $WidgetbookLocalesDataCopyWith<$Res> {
  _$WidgetbookLocalesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? importStatement = null,
    Object? dependencies = null,
    Object? locales = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: null == importStatement
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: null == dependencies
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locales: null == locales
          ? _value.locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WidgetbookLocalesDataCopyWith<$Res>
    implements $WidgetbookLocalesDataCopyWith<$Res> {
  factory _$$_WidgetbookLocalesDataCopyWith(_$_WidgetbookLocalesData value,
          $Res Function(_$_WidgetbookLocalesData) then) =
      __$$_WidgetbookLocalesDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String importStatement,
      List<String> dependencies,
      List<String> locales});
}

/// @nodoc
class __$$_WidgetbookLocalesDataCopyWithImpl<$Res>
    extends _$WidgetbookLocalesDataCopyWithImpl<$Res, _$_WidgetbookLocalesData>
    implements _$$_WidgetbookLocalesDataCopyWith<$Res> {
  __$$_WidgetbookLocalesDataCopyWithImpl(_$_WidgetbookLocalesData _value,
      $Res Function(_$_WidgetbookLocalesData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? importStatement = null,
    Object? dependencies = null,
    Object? locales = null,
  }) {
    return _then(_$_WidgetbookLocalesData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: null == importStatement
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: null == dependencies
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locales: null == locales
          ? _value._locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookLocalesData implements _WidgetbookLocalesData {
  _$_WidgetbookLocalesData(
      {required this.name,
      required this.importStatement,
      required final List<String> dependencies,
      required final List<String> locales})
      : _dependencies = dependencies,
        _locales = locales;

  factory _$_WidgetbookLocalesData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookLocalesDataFromJson(json);

  @override
  final String name;
  @override
  final String importStatement;
  final List<String> _dependencies;
  @override
  List<String> get dependencies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  final List<String> _locales;
  @override
  List<String> get locales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locales);
  }

  @override
  String toString() {
    return 'WidgetbookLocalesData(name: $name, importStatement: $importStatement, dependencies: $dependencies, locales: $locales)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookLocalesData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.importStatement, importStatement) ||
                other.importStatement == importStatement) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            const DeepCollectionEquality().equals(other._locales, _locales));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      importStatement,
      const DeepCollectionEquality().hash(_dependencies),
      const DeepCollectionEquality().hash(_locales));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WidgetbookLocalesDataCopyWith<_$_WidgetbookLocalesData> get copyWith =>
      __$$_WidgetbookLocalesDataCopyWithImpl<_$_WidgetbookLocalesData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookLocalesDataToJson(
      this,
    );
  }
}

abstract class _WidgetbookLocalesData implements WidgetbookLocalesData {
  factory _WidgetbookLocalesData(
      {required final String name,
      required final String importStatement,
      required final List<String> dependencies,
      required final List<String> locales}) = _$_WidgetbookLocalesData;

  factory _WidgetbookLocalesData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookLocalesData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  List<String> get locales;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookLocalesDataCopyWith<_$_WidgetbookLocalesData> get copyWith =>
      throw _privateConstructorUsedError;
}
