import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_core/data/model/film_model/film_model.dart';
import 'package:tmdb_core/data/model/genre_model/genre_model.dart';
import 'package:tmdb_core/data/model/video_model/video_model.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';
import 'package:tmdb_core/utils/api_constants.dart';

/// Enhanced FilmRemote repository for TMDB API operations
/// Provides comprehensive error handling and API constants usage
class FilmRemote {
  final Dio _dio;

  const FilmRemote(this._dio);

  /// Get now playing films with enhanced error handling
  Future<DataState<List<FilmModel>>> getNowPlayingFilms({int page = 1}) async {
    try {
      if (kDebugMode) {
        debugPrint('🎬 Fetching now playing films (page: $page)');
      }

      final response = await _dio.get(
        ApiConstants.nowPlayingEndpoint,
        queryParameters: {
          ApiConstants.pageParam: page,
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch now playing films',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No now playing films found');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Retrieved ${films.length} now playing films');
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getNowPlayingFilms: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getNowPlayingFilms: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get popular films with enhanced error handling
  Future<DataState<List<FilmModel>>> getPopularFilms({int page = 1}) async {
    try {
      if (kDebugMode) {
        debugPrint('🔥 Fetching popular films (page: $page)');
      }

      final response = await _dio.get(
        ApiConstants.popularEndpoint,
        queryParameters: {
          ApiConstants.pageParam: page,
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch popular films',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No popular films found');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Retrieved ${films.length} popular films');
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getPopularFilms: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getPopularFilms: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get top rated films with enhanced error handling
  Future<DataState<List<FilmModel>>> getTopRatedFilms({int page = 1}) async {
    try {
      if (kDebugMode) {
        debugPrint('⭐ Fetching top rated films (page: $page)');
      }

      final response = await _dio.get(
        ApiConstants.topRatedEndpoint,
        queryParameters: {
          ApiConstants.pageParam: page,
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch top rated films',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No top rated films found');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Retrieved ${films.length} top rated films');
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getTopRatedFilms: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getTopRatedFilms: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get upcoming films with enhanced error handling
  Future<DataState<List<FilmModel>>> getUpcomingFilms({int page = 1}) async {
    try {
      if (kDebugMode) {
        debugPrint('🔮 Fetching upcoming films (page: $page)');
      }

      final response = await _dio.get(
        ApiConstants.upcomingEndpoint,
        queryParameters: {
          ApiConstants.pageParam: page,
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch upcoming films',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No upcoming films found');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Retrieved ${films.length} upcoming films');
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getUpcomingFilms: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getUpcomingFilms: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get similar films with enhanced error handling
  Future<DataState<List<FilmModel>>> getSimilarFilms({
    required int id,
    int page = 1,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('🔗 Fetching similar films for ID $id (page: $page)');
      }

      final endpoint = ApiConstants.similarMoviesEndpoint.replaceAll(
        '{id}',
        id.toString(),
      );
      final response = await _dio.get(
        endpoint,
        queryParameters: {
          ApiConstants.pageParam: page,
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch similar films',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No similar films found for ID $id');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Retrieved ${films.length} similar films for ID $id');
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getSimilarFilms: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getSimilarFilms: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get films by genre IDs with enhanced error handling
  Future<DataState<List<FilmModel>>> getSimilarFilmsBySameGenreIds({
    required List<int> ids,
    int page = 1,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '🎭 Fetching films by genres ${ids.join(',')} (page: $page)',
        );
      }

      if (ids.isEmpty) {
        return DataState.error(message: 'Genre IDs cannot be empty');
      }

      final queryParams = {
        ApiConstants.includeAdultParam: ApiConstants.defaultIncludeAdult,
        'include_video': false,
        ApiConstants.languageParam: ApiConstants.defaultLanguage,
        ApiConstants.pageParam: page,
        'sort_by': 'popularity.desc',
        'with_genres': ids.join(','),
      };

      final response = await _dio.get(
        '/discover/movie',
        queryParameters: queryParams,
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch films by genre',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No films found for genres ${ids.join(',')}');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint(
          '✅ Retrieved ${films.length} films for genres ${ids.join(',')}',
        );
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint(
        '❌ DioException in getSimilarFilmsBySameGenreIds: ${e.message}',
      );
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getSimilarFilmsBySameGenreIds: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Search films with enhanced error handling
  Future<DataState<List<FilmModel>>> searchFilms({
    required String query,
    int page = 1,
  }) async {
    try {
      if (query.trim().isEmpty) {
        return DataState.error(message: 'Search query cannot be empty');
      }

      if (kDebugMode) {
        debugPrint('🔍 Searching films: "$query" (page: $page)');
      }

      final response = await _dio.get(
        ApiConstants.searchEndpoint,
        queryParameters: {
          ApiConstants.queryParam: query.trim(),
          ApiConstants.pageParam: page,
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
          ApiConstants.includeAdultParam: ApiConstants.defaultIncludeAdult,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to search films',
          statusCode: response.statusCode?.toString(),
        );
      }

      final results = response.data['results'] as List?;
      if (results == null || results.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No films found for query: "$query"');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = results.map((e) => FilmModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Found ${films.length} films for query: "$query"');
      }

      return DataState.success(data: films);
    } on DioException catch (e) {
      debugPrint('❌ DioException in searchFilms: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in searchFilms: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get movie genres with enhanced error handling
  Future<DataState<List<GenreModel>>> getMovieGenres() async {
    try {
      if (kDebugMode) {
        debugPrint('🎭 Fetching movie genres');
      }

      final response = await _dio.get(
        ApiConstants.genresEndpoint,
        queryParameters: {
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch movie genres',
          statusCode: response.statusCode?.toString(),
        );
      }

      final genres = response.data['genres'] as List?;
      if (genres == null || genres.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 No genres found');
        }
        return DataState.success(data: <GenreModel>[]);
      }

      final genreModels = genres.map((e) => GenreModel.fromJson(e)).toList();

      if (kDebugMode) {
        debugPrint('✅ Retrieved ${genreModels.length} genres');
      }

      return DataState.success(data: genreModels);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getMovieGenres: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getMovieGenres: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get movie details with enhanced error handling
  Future<DataState<FilmModel>> getMovieDetails({required int id}) async {
    try {
      if (kDebugMode) {
        debugPrint('📋 Fetching movie details for ID $id');
      }

      final response = await _dio.get(
        '${ApiConstants.movieDetailsEndpoint}/$id',
        queryParameters: {
          ApiConstants.languageParam: ApiConstants.defaultLanguage,
        },
      );

      if (response.statusCode != 200) {
        return DataState.error(
          message: 'Failed to fetch movie details',
          statusCode: response.statusCode?.toString(),
        );
      }

      final film = FilmModel.fromJson(response.data);

      if (kDebugMode) {
        debugPrint('✅ Retrieved movie details: ${film.title}');
      }

      return DataState.success(data: film);
    } on DioException catch (e) {
      debugPrint('❌ DioException in getMovieDetails: ${e.message}');
      return DataState.error(
        message: _getErrorMessage(e),
        stackTrace: e.stackTrace,
        exception: e.error,
        statusCode: e.response?.statusCode?.toString(),
      );
    } catch (e) {
      debugPrint('❌ Unexpected error in getMovieDetails: $e');
      return DataState.error(
        message: 'Unexpected error occurred',
        exception: e,
      );
    }
  }

  /// Get user-friendly error message from DioException
  String _getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Response timeout. Please try again.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return 'Bad request. Please check your input.';
          case 401:
            return 'Unauthorized. Please check your API key.';
          case 403:
            return 'Forbidden. Access denied.';
          case 404:
            return 'Not found. The requested resource does not exist.';
          case 429:
            return 'Too many requests. Please try again later.';
          case 500:
            return 'Server error. Please try again later.';
          default:
            return 'Request failed with status code: $statusCode';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'Connection error. Please check your internet connection.';
      case DioExceptionType.badCertificate:
        return 'Certificate error. Please check your connection.';
      case DioExceptionType.unknown:
        return e.message ?? 'Unknown error occurred';
    }
  }

  /// Get movie videos (trailers, teasers, etc.)
  Future<DataState<List<VideoModel>>> getMovieVideos({required int id}) async {
    try {
      if (kDebugMode) {
        debugPrint('🎬 Fetching videos for movie ID: $id');
      }

      final endpoint = ApiConstants.movieVideosEndpoint.replaceAll(
        '{id}',
        id.toString(),
      );
      final response = await _dio.get(endpoint);

      if (kDebugMode) {
        debugPrint('✅ Videos response received: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>? ?? [];

        final videos = results
            .map((json) => VideoModel.fromJson(json as Map<String, dynamic>))
            .where(
              (video) =>
                  video.site?.toLowerCase() == 'youtube' &&
                  video.type?.toLowerCase() == 'trailer',
            )
            .toList();

        if (kDebugMode) {
          debugPrint('📹 Found ${videos.length} trailer videos');
        }

        return DataState.success(data: videos);
      } else {
        return DataState.error(
          message: 'Failed to fetch videos',
          statusCode: response.statusCode?.toString(),
        );
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ DioException in getMovieVideos: ${e.message}');
      }
      return DataState.error(
        message: _getErrorMessage(e),
        statusCode: e.response?.statusCode?.toString(),
        exception: e,
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Unexpected error in getMovieVideos: $e');
      }
      return DataState.error(
        message: 'An unexpected error occurred while fetching videos',
        exception: e,
        stackTrace: StackTrace.current,
      );
    }
  }
}
