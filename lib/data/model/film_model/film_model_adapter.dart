import 'package:hive/hive.dart';
import 'package:tmdb_core/data/model/film_model/film_model.dart';

part 'film_model_adapter.g.dart';

@HiveType(typeId: 0)
class FilmModelAdapter extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? overview;

  @HiveField(3)
  String? backdropPath;

  @HiveField(4)
  String? posterPath;

  @HiveField(5)
  String? releaseDate;

  @HiveField(6)
  double? voteAverage;

  @HiveField(7)
  List<int>? genreIds;

  FilmModelAdapter({
    this.id,
    this.title,
    this.overview,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.genreIds,
  });

  factory FilmModelAdapter.fromFilmModel(FilmModel film) {
    return FilmModelAdapter(
      id: film.id,
      title: film.title,
      overview: film.overview,
      backdropPath: film.backdropPath,
      posterPath: film.posterPath,
      releaseDate: film.releaseDate,
      voteAverage: film.voteAverage,
      genreIds: film.genreIds,
    );
  }

  FilmModel toFilmModel() {
    return FilmModel(
      id: id,
      title: title,
      overview: overview,
      backdropPath: backdropPath,
      posterPath: posterPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      genreIds: genreIds,
    );
  }
}
