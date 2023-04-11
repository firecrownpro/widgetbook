// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_localizations_delegates_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookLocalizationsDelegatesData
    _$WidgetbookLocalizationsDelegatesDataFromJson(Map<String, dynamic> json) {
  return _WidgetbookLocalizationsDelegatesData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookLocalizationsDelegatesData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookLocalizationsDelegatesDataCopyWith<
          WidgetbookLocalizationsDelegatesData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookLocalizationsDelegatesDataCopyWith<$Res> {
  factory $WidgetbookLocalizationsDelegatesDataCopyWith(
          WidgetbookLocalizationsDelegatesData value,
          $Res Function(WidgetbookLocalizationsDelegatesData) then) =
      _$WidgetbookLocalizationsDelegatesDataCopyWithImpl<$Res,
          WidgetbookLocalizationsDelegatesData>;
  @useResult
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookLocalizationsDelegatesDataCopyWithImpl<$Res,
        $Val extends WidgetbookLocalizationsDelegatesData>
    implements $WidgetbookLocalizationsDelegatesDataCopyWith<$Res> {
  _$WidgetbookLocalizationsDelegatesDataCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WidgetbookLocalizationsDelegatesDataCopyWith<$Res>
    implements $WidgetbookLocalizationsDelegatesDataCopyWith<$Res> {
  factory _$$_WidgetbookLocalizationsDelegatesDataCopyWith(
          _$_WidgetbookLocalizationsDelegatesData value,
          $Res Function(_$_WidgetbookLocalizationsDelegatesData) then) =
      __$$_WidgetbookLocalizationsDelegatesDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$$_WidgetbookLocalizationsDelegatesDataCopyWithImpl<$Res>
    extends _$WidgetbookLocalizationsDelegatesDataCopyWithImpl<$Res,
        _$_WidgetbookLocalizationsDelegatesData>
    implements _$$_WidgetbookLocalizationsDelegatesDataCopyWith<$Res> {
  __$$_WidgetbookLocalizationsDelegatesDataCopyWithImpl(
      _$_WidgetbookLocalizationsDelegatesData _value,
      $Res Function(_$_WidgetbookLocalizationsDelegatesData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? importStatement = null,
    Object? dependencies = null,
  }) {
    return _then(_$_WidgetbookLocalizationsDelegatesData(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookLocalizationsDelegatesData
    implements _WidgetbookLocalizationsDelegatesData {
  _$_WidgetbookLocalizationsDelegatesData(
      {required this.name,
      required this.importStatement,
      required final List<String> dependencies})
      : _dependencies = dependencies;

  factory _$_WidgetbookLocalizationsDelegatesData.fromJson(
          Map<String, dynamic> json) =>
      _$$_WidgetbookLocalizationsDelegatesDataFromJson(json);

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

  @override
  String toString() {
    return 'WidgetbookLocalizationsDelegatesData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookLocalizationsDelegatesData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.importStatement, importStatement) ||
                other.importStatement == importStatement) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, importStatement,
      const DeepCollectionEquality().hash(_dependencies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WidgetbookLocalizationsDelegatesDataCopyWith<
          _$_WidgetbookLocalizationsDelegatesData>
      get copyWith => __$$_WidgetbookLocalizationsDelegatesDataCopyWithImpl<
          _$_WidgetbookLocalizationsDelegatesData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookLocalizationsDelegatesDataToJson(
      this,
    );
  }
}

abstract class _WidgetbookLocalizationsDelegatesData
    implements WidgetbookLocalizationsDelegatesData {
  factory _WidgetbookLocalizationsDelegatesData(
          {required final String name,
          required final String importStatement,
          required final List<String> dependencies}) =
      _$_WidgetbookLocalizationsDelegatesData;

  factory _WidgetbookLocalizationsDelegatesData.fromJson(
          Map<String, dynamic> json) =
      _$_WidgetbookLocalizationsDelegatesData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookLocalizationsDelegatesDataCopyWith<
          _$_WidgetbookLocalizationsDelegatesData>
      get copyWith => throw _privateConstructorUsedError;
}
