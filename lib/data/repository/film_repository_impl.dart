import 'package:flutter/foundation.dart';
import 'package:tmdb_core/data/repository/source/film_local.dart';
import 'package:tmdb_core/data/repository/source/film_remote.dart';
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_core/domain/entity/video_entity/video_entity.dart';
import 'package:tmdb_core/domain/mapper/film_mapper.dart';
import 'package:tmdb_core/domain/mapper/genre_mapper.dart';
import 'package:tmdb_core/domain/mapper/video_mapper.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

/// Enhanced FilmRepository implementation for comprehensive film operations
/// Provides consistent API for both local and remote film data operations
class FilmRepositoryImpl implements FilmRepository {
  final FilmRemote _remote;
  final FilmLocal _local;
  final FilmMapper _filmMapper;
  final GenreMapper _genreMapper;
  final VideoMapper _videoMapper;

  FilmRepositoryImpl(
    this._remote,
    this._local,
    this._filmMapper,
    this._genreMapper,
    this._videoMapper,
  );

  @override
  Future<DataState<List<GenreEntity>>> getMovieGenres() async {
    final localResult = await _local.getGenreList();
    return localResult.when(
      success: (data) =>
          DataState.success(data: _genreMapper.mapModelToEntity(data)),
      error: (message, data, exception, stackTrace, statusCode) async {
        final remoteResult = await _remote.getMovieGenres();
        return remoteResult.when(
          success: (data) async {
            await _local.addListGenre(data: data);
            return DataState.success(data: _genreMapper.mapModelToEntity(data));
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getNowPlayingFilms({int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }

    // Debug logging
    if (kDebugMode) {
      debugPrint('🎬 getNowPlayingFilms: Loaded ${genres.length} genres');
    }
    final result = await _remote.getNowPlayingFilms(page: page);
    return result.when(
      success: (remoteData) async {
        if (page == 1) {
          await _local.clearListNowPlaying();
          await _local.addListNowPlaying(nowPlayingList: remoteData);
        } else {
          await _local.addListNowPlaying(nowPlayingList: remoteData);
        }
        final localResult = await _local.getListNowPlaying();
        return localResult.when(
          success: (data) async {
            final filmList = await Future.wait(
              data.map((e) {
                return _filmMapper.mapModelToEntity(
                  filmModel: e,
                  genreEntitys: genres,
                );
              }).toList(),
            );
            return DataState.success(data: filmList);
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getPopularFilms({int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getPopularFilms(page: page);
    return result.when(
      success: (remoteData) async {
        if (page == 1) {
          await _local.clearListPopular();
          await _local.addListPopular(popularList: remoteData);
        } else {
          await _local.addListPopular(popularList: remoteData);
        }
        final localResult = await _local.getListPopular();
        return localResult.when(
          success: (data) async {
            final filmList = await Future.wait(
              data.map((e) {
                return _filmMapper.mapModelToEntity(
                  filmModel: e,
                  genreEntitys: genres,
                );
              }).toList(),
            );
            return DataState.success(data: filmList);
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
      error: (message, data, exception, stackTrace, statusCode) async {
        final localResult = await _local.getListPopular();
        return localResult.when(
          success: (data) async {
            final filmList = await Future.wait(
              data.map((e) {
                return _filmMapper.mapModelToEntity(
                  filmModel: e,
                  genreEntitys: genres,
                );
              }).toList(),
            );
            return DataState.success(data: filmList);
          },
          error: (message, data, exception, stackTrace, statusCode) {
            return DataState.error(
              message: message,
              stackTrace: stackTrace,
              exception: exception,
              statusCode: statusCode,
            );
          },
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getTopRatedFilms({int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getTopRatedFilms(page: page);
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getUpcomingFilms({int page = 1}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getUpcomingFilms(page: page);
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getSimilarFilms({
    required int id,
    int page = 1,
  }) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getSimilarFilms(id: id, page: page);
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getSimilarFilmsBySameGenreIds({
    required List<int> genreIds,
    int page = 1,
  }) async {
    List<GenreEntity> genreEntities = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genreEntities = genresResult.data!;
    }

    final result = await _remote.getSimilarFilmsBySameGenreIds(
      ids: genreIds,
      page: page,
    );
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genreEntities,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> searchFilms({
    required String query,
    int page = 1,
  }) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.searchFilms(query: query, page: page);
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<FilmEntity>> getMovieDetails({required int id}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _remote.getMovieDetails(id: id);
    return result.when(
      success: (data) async {
        final filmEntity = await _filmMapper.mapModelToEntity(
          filmModel: data,
          genreEntitys: genres,
        );
        return DataState.success(data: filmEntity);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<VideoEntity>>> getMovieVideos({required int id}) async {
    final result = await _remote.getMovieVideos(id: id);
    return result.when(
      success: (data) {
        final videoEntities = _videoMapper.mapModelToEntityList(data);
        return DataState.success(data: videoEntities);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<bool>> addFavorite({required FilmEntity data}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    return await _local.addFavorite(
      favoriteData: _filmMapper.mapEntityToModel(
        filmEntity: data,
        genreEntitys: genres,
      ),
    );
  }

  @override
  Future<DataState<bool>> addWatchlist({required FilmEntity data}) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    return await _local.addWatchlist(
      watchlistData: _filmMapper.mapEntityToModel(
        filmEntity: data,
        genreEntitys: genres,
      ),
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getListFavorite() async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _local.getListFavorite();
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getListWatchlist() async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _local.getListWatchlist();
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  DataState<bool> isOnFavorite(int id) => _local.isOnFavorited(id);

  @override
  DataState<bool> isOnWatchlist(int id) => _local.isOnWatchlist(id);

  @override
  Future<DataState<bool>> removeFromFavorite(int id) async {
    return await _local.removeFromFavorite(id);
  }

  @override
  Future<DataState<bool>> removeFromWatchlist(int id) async {
    return await _local.removeFromWatchlist(id);
  }

  // Cache management operations

  @override
  Future<DataState<bool>> addListGenre({
    required List<GenreEntity> data,
  }) async {
    return await _local.addListGenre(data: _genreMapper.mapEntityToModel(data));
  }

  @override
  Future<DataState<List<GenreEntity>>> getGenreList() async {
    final result = await _local.getGenreList();
    return result.when(
      success: (data) =>
          DataState.success(data: _genreMapper.mapModelToEntity(data)),
      error: (message, data, exception, stackTrace, statusCode) =>
          DataState.error(
            message: message,
            stackTrace: stackTrace,
            exception: exception,
            statusCode: statusCode,
          ),
    );
  }

  @override
  Future<DataState<bool>> addListPopular({
    required List<FilmEntity> popularList,
  }) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    return await _local.addListPopular(
      popularList: popularList
          .map(
            (e) => _filmMapper.mapEntityToModel(
              filmEntity: e,
              genreEntitys: genres,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getListPopular() async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _local.getListPopular();
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<bool>> clearListPopular() async {
    return await _local.clearListPopular();
  }

  @override
  Future<DataState<bool>> addListNowPlaying({
    required List<FilmEntity> nowPlayingList,
  }) async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    return await _local.addListNowPlaying(
      nowPlayingList: nowPlayingList
          .map(
            (e) => _filmMapper.mapEntityToModel(
              filmEntity: e,
              genreEntitys: genres,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<DataState<List<FilmEntity>>> getListNowPlaying() async {
    List<GenreEntity> genres = [];
    final genresResult = await getMovieGenres();
    if (genresResult.data != null) {
      genres = genresResult.data!;
    }
    final result = await _local.getListNowPlaying();
    return result.when(
      success: (data) async {
        final filmList = await Future.wait(
          data.map((e) {
            return _filmMapper.mapModelToEntity(
              filmModel: e,
              genreEntitys: genres,
            );
          }).toList(),
        );
        return DataState.success(data: filmList);
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          stackTrace: stackTrace,
          exception: exception,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<bool>> clearListNowPlaying() async {
    return await _local.clearListNowPlaying();
  }

  @override
  Future<DataState<bool>> clearAllCache() async {
    return await _local.clearAllCache();
  }

  @override
  Map<String, dynamic> getStorageStats() {
    return _local.getStorageStats();
  }
}
