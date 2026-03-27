import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_core/domain/entity/video_entity/video_entity.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

/// Enhanced FilmRepository interface for comprehensive film operations
/// Provides consistent API for both local and remote film data operations
abstract class FilmRepository {
  // Remote API operations

  /// Get now playing films from TMDB API
  Future<DataState<List<FilmEntity>>> getNowPlayingFilms({int page = 1});

  /// Get popular films from TMDB API
  Future<DataState<List<FilmEntity>>> getPopularFilms({int page = 1});

  /// Get top rated films from TMDB API
  Future<DataState<List<FilmEntity>>> getTopRatedFilms({int page = 1});

  /// Get upcoming films from TMDB API
  Future<DataState<List<FilmEntity>>> getUpcomingFilms({int page = 1});

  /// Get similar films for a specific movie
  Future<DataState<List<FilmEntity>>> getSimilarFilms({
    required int id,
    int page = 1,
  });

  /// Get films by genre IDs
  Future<DataState<List<FilmEntity>>> getSimilarFilmsBySameGenreIds({
    required List<int> genreIds,
    int page = 1,
  });

  /// Search films by query
  Future<DataState<List<FilmEntity>>> searchFilms({
    required String query,
    int page = 1,
  });

  /// Get movie genres from TMDB API
  Future<DataState<List<GenreEntity>>> getMovieGenres();

  /// Get detailed movie information
  Future<DataState<FilmEntity>> getMovieDetails({required int id});

  /// Get movie videos (trailers, teasers, etc.)
  Future<DataState<List<VideoEntity>>> getMovieVideos({required int id});

  // Local storage operations

  /// Add film to watchlist
  Future<DataState<bool>> addWatchlist({required FilmEntity data});

  /// Get watchlist films
  Future<DataState<List<FilmEntity>>> getListWatchlist();

  /// Check if film is in watchlist
  DataState<bool> isOnWatchlist(int id);

  /// Remove film from watchlist
  Future<DataState<bool>> removeFromWatchlist(int id);

  /// Add film to favorites
  Future<DataState<bool>> addFavorite({required FilmEntity data});

  /// Get favorite films
  Future<DataState<List<FilmEntity>>> getListFavorite();

  /// Check if film is in favorites
  DataState<bool> isOnFavorite(int id);

  /// Remove film from favorites
  Future<DataState<bool>> removeFromFavorite(int id);

  // Cache management operations

  /// Store genre list locally
  Future<DataState<bool>> addListGenre({required List<GenreEntity> data});

  /// Get genre list from local storage
  Future<DataState<List<GenreEntity>>> getGenreList();

  /// Store popular films list locally
  Future<DataState<bool>> addListPopular({
    required List<FilmEntity> popularList,
  });

  /// Get popular films list from local storage
  Future<DataState<List<FilmEntity>>> getListPopular();

  /// Clear popular films cache
  Future<DataState<bool>> clearListPopular();

  /// Store now playing films list locally
  Future<DataState<bool>> addListNowPlaying({
    required List<FilmEntity> nowPlayingList,
  });

  /// Get now playing films list from local storage
  Future<DataState<List<FilmEntity>>> getListNowPlaying();

  /// Clear now playing films cache
  Future<DataState<bool>> clearListNowPlaying();

  /// Clear all cached data
  Future<DataState<bool>> clearAllCache();

  /// Get storage statistics
  Map<String, dynamic> getStorageStats();
}
