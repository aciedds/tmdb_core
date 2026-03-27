// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoEntity {
  String get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get site => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get official => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String? get publishedAt => throw _privateConstructorUsedError;

  /// Create a copy of VideoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoEntityCopyWith<VideoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoEntityCopyWith<$Res> {
  factory $VideoEntityCopyWith(
          VideoEntity value, $Res Function(VideoEntity) then) =
      _$VideoEntityCopyWithImpl<$Res, VideoEntity>;
  @useResult
  $Res call(
      {String id,
      String key,
      String name,
      String site,
      String type,
      bool official,
      int size,
      String? publishedAt});
}

/// @nodoc
class _$VideoEntityCopyWithImpl<$Res, $Val extends VideoEntity>
    implements $VideoEntityCopyWith<$Res> {
  _$VideoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? site = null,
    Object? type = null,
    Object? official = null,
    Object? size = null,
    Object? publishedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      site: null == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      official: null == official
          ? _value.official
          : official // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoEntityImplCopyWith<$Res>
    implements $VideoEntityCopyWith<$Res> {
  factory _$$VideoEntityImplCopyWith(
          _$VideoEntityImpl value, $Res Function(_$VideoEntityImpl) then) =
      __$$VideoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String key,
      String name,
      String site,
      String type,
      bool official,
      int size,
      String? publishedAt});
}

/// @nodoc
class __$$VideoEntityImplCopyWithImpl<$Res>
    extends _$VideoEntityCopyWithImpl<$Res, _$VideoEntityImpl>
    implements _$$VideoEntityImplCopyWith<$Res> {
  __$$VideoEntityImplCopyWithImpl(
      _$VideoEntityImpl _value, $Res Function(_$VideoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? site = null,
    Object? type = null,
    Object? official = null,
    Object? size = null,
    Object? publishedAt = freezed,
  }) {
    return _then(_$VideoEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      site: null == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      official: null == official
          ? _value.official
          : official // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VideoEntityImpl implements _VideoEntity {
  _$VideoEntityImpl(
      {required this.id,
      required this.key,
      required this.name,
      required this.site,
      required this.type,
      required this.official,
      required this.size,
      this.publishedAt});

  @override
  final String id;
  @override
  final String key;
  @override
  final String name;
  @override
  final String site;
  @override
  final String type;
  @override
  final bool official;
  @override
  final int size;
  @override
  final String? publishedAt;

  @override
  String toString() {
    return 'VideoEntity(id: $id, key: $key, name: $name, site: $site, type: $type, official: $official, size: $size, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.site, site) || other.site == site) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.official, official) ||
                other.official == official) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, key, name, site, type, official, size, publishedAt);

  /// Create a copy of VideoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoEntityImplCopyWith<_$VideoEntityImpl> get copyWith =>
      __$$VideoEntityImplCopyWithImpl<_$VideoEntityImpl>(this, _$identity);
}

abstract class _VideoEntity implements VideoEntity {
  factory _VideoEntity(
      {required final String id,
      required final String key,
      required final String name,
      required final String site,
      required final String type,
      required final bool official,
      required final int size,
      final String? publishedAt}) = _$VideoEntityImpl;

  @override
  String get id;
  @override
  String get key;
  @override
  String get name;
  @override
  String get site;
  @override
  String get type;
  @override
  bool get official;
  @override
  int get size;
  @override
  String? get publishedAt;

  /// Create a copy of VideoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoEntityImplCopyWith<_$VideoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
