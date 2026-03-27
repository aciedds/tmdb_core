// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FilmEntity {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  String get backdropPath => throw _privateConstructorUsedError;
  String get posterPath => throw _privateConstructorUsedError;
  String get releaseDate => throw _privateConstructorUsedError;
  double get voteAverage => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;

  /// Create a copy of FilmEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilmEntityCopyWith<FilmEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilmEntityCopyWith<$Res> {
  factory $FilmEntityCopyWith(
          FilmEntity value, $Res Function(FilmEntity) then) =
      _$FilmEntityCopyWithImpl<$Res, FilmEntity>;
  @useResult
  $Res call(
      {int id,
      String title,
      String overview,
      String backdropPath,
      String posterPath,
      String releaseDate,
      double voteAverage,
      List<String> genres});
}

/// @nodoc
class _$FilmEntityCopyWithImpl<$Res, $Val extends FilmEntity>
    implements $FilmEntityCopyWith<$Res> {
  _$FilmEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilmEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? backdropPath = null,
    Object? posterPath = null,
    Object? releaseDate = null,
    Object? voteAverage = null,
    Object? genres = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: null == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: null == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilmEntityImplCopyWith<$Res>
    implements $FilmEntityCopyWith<$Res> {
  factory _$$FilmEntityImplCopyWith(
          _$FilmEntityImpl value, $Res Function(_$FilmEntityImpl) then) =
      __$$FilmEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String overview,
      String backdropPath,
      String posterPath,
      String releaseDate,
      double voteAverage,
      List<String> genres});
}

/// @nodoc
class __$$FilmEntityImplCopyWithImpl<$Res>
    extends _$FilmEntityCopyWithImpl<$Res, _$FilmEntityImpl>
    implements _$$FilmEntityImplCopyWith<$Res> {
  __$$FilmEntityImplCopyWithImpl(
      _$FilmEntityImpl _value, $Res Function(_$FilmEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilmEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? backdropPath = null,
    Object? posterPath = null,
    Object? releaseDate = null,
    Object? voteAverage = null,
    Object? genres = null,
  }) {
    return _then(_$FilmEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: null == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: null == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FilmEntityImpl implements _FilmEntity {
  _$FilmEntityImpl(
      {required this.id,
      required this.title,
      required this.overview,
      required this.backdropPath,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required final List<String> genres})
      : _genres = genres;

  @override
  final int id;
  @override
  final String title;
  @override
  final String overview;
  @override
  final String backdropPath;
  @override
  final String posterPath;
  @override
  final String releaseDate;
  @override
  final double voteAverage;
  final List<String> _genres;
  @override
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'FilmEntity(id: $id, title: $title, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath, releaseDate: $releaseDate, voteAverage: $voteAverage, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilmEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      overview,
      backdropPath,
      posterPath,
      releaseDate,
      voteAverage,
      const DeepCollectionEquality().hash(_genres));

  /// Create a copy of FilmEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilmEntityImplCopyWith<_$FilmEntityImpl> get copyWith =>
      __$$FilmEntityImplCopyWithImpl<_$FilmEntityImpl>(this, _$identity);
}

abstract class _FilmEntity implements FilmEntity {
  factory _FilmEntity(
      {required final int id,
      required final String title,
      required final String overview,
      required final String backdropPath,
      required final String posterPath,
      required final String releaseDate,
      required final double voteAverage,
      required final List<String> genres}) = _$FilmEntityImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String get overview;
  @override
  String get backdropPath;
  @override
  String get posterPath;
  @override
  String get releaseDate;
  @override
  double get voteAverage;
  @override
  List<String> get genres;

  /// Create a copy of FilmEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilmEntityImplCopyWith<_$FilmEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
