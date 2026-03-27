import 'package:flutter/foundation.dart';
import 'package:tmdb_core/data/repository/film_repository_impl.dart';
import 'package:tmdb_core/data/repository/source/film_local.dart';
import 'package:tmdb_core/data/repository/source/film_remote.dart';
import 'package:tmdb_core/domain/mapper/film_mapper.dart';
import 'package:tmdb_core/domain/mapper/genre_mapper.dart';
import 'package:tmdb_core/domain/mapper/video_mapper.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/domain/usecase/add_favorite_uc.dart';
import 'package:tmdb_core/domain/usecase/add_watchlist_uc.dart';
import 'package:tmdb_core/domain/usecase/get_favorite_uc.dart';
import 'package:tmdb_core/domain/usecase/get_has_exist_in_favorite_uc.dart';
import 'package:tmdb_core/domain/usecase/get_has_exist_in_watchlist_uc.dart';
import 'package:tmdb_core/domain/usecase/get_movie_genres_uc.dart';
import 'package:tmdb_core/domain/usecase/get_movie_videos_uc.dart';
import 'package:tmdb_core/domain/usecase/get_now_playing_uc.dart';
import 'package:tmdb_core/domain/usecase/get_popular_film_uc.dart';
import 'package:tmdb_core/domain/usecase/get_search_film_uc.dart';
import 'package:tmdb_core/domain/usecase/get_similar_film_by_genre_ids_uc.dart';
import 'package:tmdb_core/domain/usecase/get_similar_film_uc.dart';
import 'package:tmdb_core/domain/usecase/get_watchlist_uc.dart';
import 'package:tmdb_core/domain/usecase/remove_from_favorite_uc.dart';
import 'package:tmdb_core/domain/usecase/remove_from_watchlist_uc.dart';
import 'package:tmdb_core/utils/dio_utils.dart';
import 'package:tmdb_core/utils/environment_config.dart';
import 'package:tmdb_core/utils/local_storage_utils.dart';

export 'domain/entity/film_entity/film_entity.dart';
export 'domain/entity/genre_entity/genre_entity.dart';
export 'domain/entity/video_entity/video_entity.dart';
export 'domain/repository/film_repository.dart';
export 'domain/usecase/add_favorite_uc.dart';
export 'domain/usecase/add_watchlist_uc.dart';
export 'domain/usecase/get_favorite_uc.dart';
export 'domain/usecase/get_has_exist_in_favorite_uc.dart';
export 'domain/usecase/get_has_exist_in_watchlist_uc.dart';
export 'domain/usecase/get_movie_genres_uc.dart';
export 'domain/usecase/get_movie_videos_uc.dart';
export 'domain/usecase/get_now_playing_uc.dart';
export 'domain/usecase/get_popular_film_uc.dart';
export 'domain/usecase/get_search_film_uc.dart';
export 'domain/usecase/get_similar_film_by_genre_ids_uc.dart';
export 'domain/usecase/get_similar_film_uc.dart';
export 'domain/usecase/get_watchlist_uc.dart';
export 'domain/usecase/remove_from_favorite_uc.dart';
export 'domain/usecase/remove_from_watchlist_uc.dart';
export 'state/data_state/data_state.dart';

class TmdbCore {
  TmdbCore._();

  static FilmLocal? _filmLocal;
  static FilmRemote? _filmRemote;
  static FilmRepositoryImpl? _filmRepository;
  static TmdbCoreUseCases? _useCases;
  static bool _isInitialized = false;
  static Future<void>? _initializing;

  static Future<void> initialize({
    required String baseUrl,
    required String apiKey,
    required String imageBaseUrl,
    required String largeImageBaseUrl,
    required String appName,
    required String appVersion,
    required bool debugMode,
  }) async {
    if (_isInitialized) return;
    final inProgress = _initializing;
    if (inProgress != null) {
      await inProgress;
      return;
    }

    _initializing = () async {
      // 1) Initialize environment first because DioUtils reads ApiConstants.
      await EnvironmentConfig.initialize(
        baseUrl: baseUrl,
        apiKey: apiKey,
        imageBaseUrl: imageBaseUrl,
        largeImageBaseUrl: largeImageBaseUrl,
        appName: appName,
        appVersion: appVersion,
        debugMode: debugMode,
      );


      // 3) Build low-level services.
      final localStorageUtils = await LocalStorageUtils.instance();
      _filmLocal = FilmLocal(localStorageUtils);

      final dio = await DioUtils.client();
      _filmRemote = FilmRemote(dio);

      // 4) Build repository and use cases.
      _filmRepository = FilmRepositoryImpl(
        _filmRemote!,
        _filmLocal!,
        FilmMapper(),
        GenreMapper(),
        VideoMapper(),
      );
      _useCases = TmdbCoreUseCases(_filmRepository!);
      _isInitialized = true;

      if (debugMode) {
        debugPrint(
          '🚀 TmdbCore initialized with config: ${EnvironmentConfig.getAllVars()}',
        );
      }
    }();

    try {
      await _initializing;
    } finally {
      _initializing = null;
    }
  }

  static void _ensureInitialized() {
    if (!_isInitialized ||
        _filmLocal == null ||
        _filmRemote == null ||
        _filmRepository == null) {
      throw StateError(
        'TmdbCore is not initialized. Call TmdbCore.initialize() first.',
      );
    }
  }

  static FilmLocal createFilmLocal() {
    _ensureInitialized();
    return _filmLocal!;
  }

  static FilmRemote createFilmRemote() {
    _ensureInitialized();
    return _filmRemote!;
  }

  static FilmRepository createFilmRepository() {
    _ensureInitialized();
    return _filmRepository!;
  }

  static TmdbCoreUseCases createUseCases() {
    _ensureInitialized();
    return _useCases ??= TmdbCoreUseCases(_filmRepository!);
  }

  static void reset() {
    _filmLocal = null;
    _filmRemote = null;
    _filmRepository = null;
    _useCases = null;
    _isInitialized = false;
    _initializing = null;
  }
}

class TmdbCoreUseCases {
  TmdbCoreUseCases._({
    required this.getPopularFilmUc,
    required this.getNowPlayingUc,
    required this.getMovieGenresUc,
    required this.getSimilarFilmUc,
    required this.getSimilarFilmByGenresUc,
    required this.getSearchFilmUc,
    required this.getMovieVideosUc,
    required this.getFavoriteUc,
    required this.getWatchlistUc,
    required this.getHasExistInFavoriteUc,
    required this.getHasExistInWatchlistUc,
    required this.addFavoriteUc,
    required this.addWatchlistUc,
    required this.removeFromFavoriteUc,
    required this.removeFromWatchlistUc,
  });

  factory TmdbCoreUseCases(FilmRepository repository) {
    return TmdbCoreUseCases._(
      getPopularFilmUc: GetPopularFilmUc(repository),
      getNowPlayingUc: GetNowPlayingUc(repository),
      getMovieGenresUc: GetMovieGenresUc(repository),
      getSimilarFilmUc: GetSimilarFilmUc(repository),
      getSimilarFilmByGenresUc: GetSimilarFilmByGenresUc(repository),
      getSearchFilmUc: GetSearchFilmUc(repository),
      getMovieVideosUc: GetMovieVideosUc(repository),
      getFavoriteUc: GetFavoriteUc(repository),
      getWatchlistUc: GetWatchlistUc(repository),
      getHasExistInFavoriteUc: GetHasExistInFavoriteUc(repository),
      getHasExistInWatchlistUc: GetHasExistInWatchlistUc(repository),
      addFavoriteUc: AddFavoriteUc(repository),
      addWatchlistUc: AddWatchlistUc(repository),
      removeFromFavoriteUc: RemoveFromFavoriteUc(repository),
      removeFromWatchlistUc: RemoveFromWatchlistUc(repository),
    );
  }

  final GetPopularFilmUc getPopularFilmUc;
  final GetNowPlayingUc getNowPlayingUc;
  final GetMovieGenresUc getMovieGenresUc;
  final GetSimilarFilmUc getSimilarFilmUc;
  final GetSimilarFilmByGenresUc getSimilarFilmByGenresUc;
  final GetSearchFilmUc getSearchFilmUc;
  final GetMovieVideosUc getMovieVideosUc;
  final GetFavoriteUc getFavoriteUc;
  final GetWatchlistUc getWatchlistUc;
  final GetHasExistInFavoriteUc getHasExistInFavoriteUc;
  final GetHasExistInWatchlistUc getHasExistInWatchlistUc;
  final AddFavoriteUc addFavoriteUc;
  final AddWatchlistUc addWatchlistUc;
  final RemoveFromFavoriteUc removeFromFavoriteUc;
  final RemoveFromWatchlistUc removeFromWatchlistUc;
}
