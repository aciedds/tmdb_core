import 'package:json_annotation/json_annotation.dart';

part 'film_model.g.dart';

@JsonSerializable()
class FilmModel {
  final int? id;
  final String? title;
  final String? overview;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  FilmModel({
    this.id,
    this.title,
    this.overview,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.genreIds,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) =>
      _$FilmModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilmModelToJson(this);
}
