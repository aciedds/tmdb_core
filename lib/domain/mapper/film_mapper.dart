import 'dart:convert';

import 'package:tmdb_core/data/model/film_model/film_model.dart';
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_core/utils/image_utils.dart';

class FilmMapper {
  Future<FilmEntity> mapModelToEntity({
    required FilmModel filmModel,
    required List<GenreEntity> genreEntitys,
  }) async {
    List<String> genres = [];
    if (filmModel.genreIds != null) {
      if (genreEntitys.isNotEmpty) {
        genres = filmModel.genreIds!.map((e) {
          try {
            return genreEntitys.firstWhere((genre) => genre.id == e).name;
          } catch (e) {
            // If genre not found, return a default name
            return 'Unknown Genre';
          }
        }).toList();
      } else {
        // If no genres are loaded, use a fallback mapping
        final genreIdToNameMap = {
          28: 'Action',
          12: 'Adventure',
          16: 'Animation',
          35: 'Comedy',
          80: 'Crime',
          99: 'Documentary',
          18: 'Drama',
          10751: 'Family',
          14: 'Fantasy',
          36: 'History',
          27: 'Horror',
          10402: 'Music',
          9648: 'Mystery',
          10749: 'Romance',
          878: 'Science Fiction',
          10770: 'TV Movie',
          53: 'Thriller',
          10752: 'War',
          37: 'Western',
        };

        genres = filmModel.genreIds!
            .map((e) => genreIdToNameMap[e] ?? 'Unknown Genre')
            .toList();
      }
    }

    String? posterBase64Image;
    if (filmModel.posterPath != null) {
      if (!_isBase64Encoded(filmModel.posterPath!)) {
        posterBase64Image = await ImageUtils.imageToBase64(
          filmModel.posterPath!,
        );
      } else {
        posterBase64Image = filmModel.posterPath;
      }
    }

    String? backdropBase64Image;
    if (filmModel.backdropPath != null) {
      if (!_isBase64Encoded(filmModel.backdropPath!)) {
        backdropBase64Image = await ImageUtils.imageToBase64(
          filmModel.backdropPath!,
        );
      } else {
        backdropBase64Image = filmModel.backdropPath;
      }
    }

    return FilmEntity(
      id: filmModel.id ?? 0,
      title: filmModel.title ?? '',
      overview: filmModel.overview ?? '',
      backdropPath: backdropBase64Image ?? '',
      posterPath: posterBase64Image ?? '',
      releaseDate: filmModel.releaseDate ?? '',
      voteAverage: filmModel.voteAverage ?? 0.0,
      genres: genres,
    );
  }

  bool _isBase64Encoded(String data) {
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');
    if (!base64Pattern.hasMatch(data) || data.length % 4 != 0) {
      return false;
    }
    try {
      base64Decode(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  FilmModel mapEntityToModel({
    required FilmEntity filmEntity,
    required List<GenreEntity> genreEntitys,
  }) {
    List<int> genreIds = [];
    if (genreEntitys.isNotEmpty) {
      genreIds = filmEntity.genres.map((e) {
        try {
          return genreEntitys.firstWhere((genre) => genre.name == e).id;
        } catch (e) {
          // If genre not found, return 0 as default
          return 0;
        }
      }).toList();
    }

    return FilmModel(
      id: filmEntity.id,
      title: filmEntity.title,
      overview: filmEntity.overview,
      backdropPath: filmEntity.backdropPath,
      posterPath: filmEntity.posterPath,
      releaseDate: filmEntity.releaseDate,
      voteAverage: filmEntity.voteAverage,
      genreIds: genreIds,
    );
  }
}
