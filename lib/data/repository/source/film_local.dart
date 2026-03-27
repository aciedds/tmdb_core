import 'package:flutter/foundation.dart';

import 'package:tmdb_core/data/model/film_model/film_model.dart';
import 'package:tmdb_core/data/model/genre_model/genre_model.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';
import 'package:tmdb_core/utils/hive_utils.dart';

/// Enhanced FilmLocal repository for local storage operations
/// Provides type-safe operations with comprehensive error handling
class FilmLocal {
  final HiveUtils _hiveUtils;

  FilmLocal(this._hiveUtils);

  // Storage keys
  static const String _watchlistKey = 'watchList';
  static const String _favoriteKey = 'favoriteList';
  static const String _genreKey = 'genreList';
  static const String _popularKey = 'popularList';
  static const String _nowPlayingKey = 'nowPlayingList';

  /// Add film to watchlist with enhanced error handling
  Future<DataState<bool>> addWatchlist({
    required FilmModel watchlistData,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '📝 Adding film to watchlist: ${watchlistData.title} (ID: ${watchlistData.id})',
        );
      }

      final result = await getListWatchlist();
      return result.when(
        success: (existingList) async {
          List<FilmModel> temp = List.from(existingList);

          // Remove if already exists (toggle behavior)
          if (temp.any((e) => e.id == watchlistData.id)) {
            temp.removeWhere((element) => element.id == watchlistData.id);
            if (kDebugMode) {
              debugPrint(
                '🔄 Removed film from watchlist: ${watchlistData.title}',
              );
            }
          } else {
            temp.add(watchlistData);
            if (kDebugMode) {
              debugPrint('✅ Added film to watchlist: ${watchlistData.title}');
            }
          }

          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _watchlistKey,
            data: temp,
          );

          return success
              ? DataState.success(data: true)
              : DataState.error(message: 'Failed to save watchlist data');
        },
        error: (message, data, exception, stackTrace, statusCode) async {
          // If no existing data, create new list
          List<FilmModel> temp = [watchlistData];
          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _watchlistKey,
            data: temp,
          );

          return success
              ? DataState.success(data: true)
              : DataState.error(message: 'Failed to create new watchlist');
        },
      );
    } catch (e) {
      debugPrint('❌ Error adding to watchlist: $e');
      return DataState.error(
        message: 'Failed to add film to watchlist',
        exception: e,
      );
    }
  }

  /// Get watchlist with enhanced error handling
  Future<DataState<List<FilmModel>>> getListWatchlist() async {
    try {
      final result = _hiveUtils.get<List<FilmModel>>(key: _watchlistKey);

      if (result == null || result.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 Watchlist is empty');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = result;

      if (kDebugMode) {
        debugPrint('📖 Retrieved ${films.length} films from watchlist');
      }

      return DataState.success(data: films);
    } catch (e) {
      debugPrint('❌ Error getting watchlist: $e');
      return DataState.error(
        message: 'Failed to retrieve watchlist',
        exception: e,
      );
    }
  }

  /// Check if film is in watchlist
  DataState<bool> isOnWatchlist(int id) {
    try {
      final result = _hiveUtils.get<List<FilmModel>>(key: _watchlistKey);

      if (result == null || result.isEmpty) {
        return DataState.success(data: false);
      }

      final contains = result.any((element) => element.id == id);

      if (kDebugMode) {
        debugPrint('🔍 Film ID $id ${contains ? 'is' : 'is not'} in watchlist');
      }

      return DataState.success(data: contains);
    } catch (e) {
      debugPrint('❌ Error checking watchlist status: $e');
      return DataState.error(
        message: 'Failed to check watchlist status',
        exception: e,
      );
    }
  }

  /// Remove film from watchlist
  Future<DataState<bool>> removeFromWatchlist(int id) async {
    try {
      if (kDebugMode) {
        debugPrint('🗑️ Removing film ID $id from watchlist');
      }

      final result = _hiveUtils.get<List<FilmModel>>(key: _watchlistKey);

      if (result == null || result.isEmpty) {
        return DataState.error(message: 'Watchlist is empty');
      }

      final updatedList = result.where((element) => element.id != id).toList();

      final success = await _hiveUtils.set<List<dynamic>>(
        key: _watchlistKey,
        data: updatedList,
      );

      if (success) {
        if (kDebugMode) {
          debugPrint('✅ Successfully removed film ID $id from watchlist');
        }
        return DataState.success(data: true);
      } else {
        return DataState.error(message: 'Failed to remove film from watchlist');
      }
    } catch (e) {
      debugPrint('❌ Error removing from watchlist: $e');
      return DataState.error(
        message: 'Failed to remove film from watchlist',
        exception: e,
      );
    }
  }

  /// Add film to favorites with enhanced error handling
  Future<DataState<bool>> addFavorite({required FilmModel favoriteData}) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '❤️ Adding film to favorites: ${favoriteData.title} (ID: ${favoriteData.id})',
        );
      }

      final result = await getListFavorite();
      return result.when(
        success: (existingList) async {
          List<FilmModel> temp = List.from(existingList);

          // Remove if already exists (toggle behavior)
          if (temp.any((e) => e.id == favoriteData.id)) {
            temp.removeWhere((element) => element.id == favoriteData.id);
            if (kDebugMode) {
              debugPrint(
                '🔄 Removed film from favorites: ${favoriteData.title}',
              );
            }
          } else {
            temp.add(favoriteData);
            if (kDebugMode) {
              debugPrint('✅ Added film to favorites: ${favoriteData.title}');
            }
          }

          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _favoriteKey,
            data: temp,
          );

          return success
              ? DataState.success(data: true)
              : DataState.error(message: 'Failed to save favorites data');
        },
        error: (message, data, exception, stackTrace, statusCode) async {
          // If no existing data, create new list
          List<FilmModel> temp = [favoriteData];
          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _favoriteKey,
            data: temp,
          );

          return success
              ? DataState.success(data: true)
              : DataState.error(message: 'Failed to create new favorites list');
        },
      );
    } catch (e) {
      debugPrint('❌ Error adding to favorites: $e');
      return DataState.error(
        message: 'Failed to add film to favorites',
        exception: e,
      );
    }
  }

  /// Get favorites list with enhanced error handling
  Future<DataState<List<FilmModel>>> getListFavorite() async {
    try {
      final result = _hiveUtils.get<List<FilmModel>>(key: _favoriteKey);

      if (result == null || result.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 Favorites list is empty');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = result;

      if (kDebugMode) {
        debugPrint('📖 Retrieved ${films.length} films from favorites');
      }

      return DataState.success(data: films);
    } catch (e) {
      debugPrint('❌ Error getting favorites: $e');
      return DataState.error(
        message: 'Failed to retrieve favorites',
        exception: e,
      );
    }
  }

  /// Check if film is in favorites
  DataState<bool> isOnFavorited(int id) {
    try {
      final result = _hiveUtils.get<List<FilmModel>>(key: _favoriteKey);

      if (result == null || result.isEmpty) {
        return DataState.success(data: false);
      }

      final contains = result.any((element) => element.id == id);

      if (kDebugMode) {
        debugPrint('🔍 Film ID $id ${contains ? 'is' : 'is not'} in favorites');
      }

      return DataState.success(data: contains);
    } catch (e) {
      debugPrint('❌ Error checking favorites status: $e');
      return DataState.error(
        message: 'Failed to check favorites status',
        exception: e,
      );
    }
  }

  /// Remove film from favorites
  Future<DataState<bool>> removeFromFavorite(int id) async {
    try {
      if (kDebugMode) {
        debugPrint('🗑️ Removing film ID $id from favorites');
      }

      final result = _hiveUtils.get<List<FilmModel>>(key: _favoriteKey);

      if (result == null || result.isEmpty) {
        return DataState.error(message: 'Favorites list is empty');
      }

      final updatedList = result.where((element) => element.id != id).toList();

      final success = await _hiveUtils.set<List<dynamic>>(
        key: _favoriteKey,
        data: updatedList,
      );

      if (success) {
        if (kDebugMode) {
          debugPrint('✅ Successfully removed film ID $id from favorites');
        }
        return DataState.success(data: true);
      } else {
        return DataState.error(message: 'Failed to remove film from favorites');
      }
    } catch (e) {
      debugPrint('❌ Error removing from favorites: $e');
      return DataState.error(
        message: 'Failed to remove film from favorites',
        exception: e,
      );
    }
  }

  /// Add genre list with caching
  Future<DataState<bool>> addListGenre({required List<GenreModel> data}) async {
    try {
      if (kDebugMode) {
        debugPrint('🎭 Storing ${data.length} genres');
      }

      final success = await _hiveUtils.set<List<GenreModel>>(
        key: _genreKey,
        data: data,
      );

      return success
          ? DataState.success(data: true)
          : DataState.error(message: 'Failed to store genre data');
    } catch (e) {
      debugPrint('❌ Error storing genres: $e');
      return DataState.error(
        message: 'Failed to store genre data',
        exception: e,
      );
    }
  }

  /// Get genre list with caching
  Future<DataState<List<GenreModel>>> getGenreList() async {
    try {
      final result = _hiveUtils.get<List<GenreModel>>(key: _genreKey);

      if (result == null || result.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 Genre list is empty');
        }
        return DataState.success(data: <GenreModel>[]);
      }

      final genres = result;

      if (kDebugMode) {
        debugPrint('📖 Retrieved ${genres.length} genres');
      }

      return DataState.success(data: genres);
    } catch (e) {
      debugPrint('❌ Error getting genres: $e');
      return DataState.error(
        message: 'Failed to retrieve genre data',
        exception: e,
      );
    }
  }

  /// Add popular films list with deduplication
  Future<DataState<bool>> addListPopular({
    required List<FilmModel> popularList,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('🔥 Adding ${popularList.length} popular films');
      }

      final result = await getListPopular();
      return result.when(
        success: (existingList) async {
          List<FilmModel> temp = List.from(existingList);

          // Add new films, avoiding duplicates
          for (var element in popularList) {
            if (!temp.any((e) => e.id == element.id)) {
              temp.add(element);
            }
          }

          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _popularKey,
            data: temp,
          );

          if (success && kDebugMode) {
            debugPrint(
              '✅ Stored ${temp.length} popular films (${popularList.length} new)',
            );
          }

          return success
              ? DataState.success(data: true)
              : DataState.error(message: 'Failed to store popular films');
        },
        error: (message, data, exception, stackTrace, statusCode) async {
          // If no existing data, create new list
          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _popularKey,
            data: popularList,
          );

          return success
              ? DataState.success(data: true)
              : DataState.error(
                  message: 'Failed to create new popular films list',
                );
        },
      );
    } catch (e) {
      debugPrint('❌ Error storing popular films: $e');
      return DataState.error(
        message: 'Failed to store popular films',
        exception: e,
      );
    }
  }

  /// Get popular films list
  Future<DataState<List<FilmModel>>> getListPopular() async {
    try {
      final result = _hiveUtils.get<List<FilmModel>>(key: _popularKey);

      if (result == null || result.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 Popular films list is empty');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = result;

      if (kDebugMode) {
        debugPrint('📖 Retrieved ${films.length} popular films');
      }

      return DataState.success(data: films);
    } catch (e) {
      debugPrint('❌ Error getting popular films: $e');
      return DataState.error(
        message: 'Failed to retrieve popular films',
        exception: e,
      );
    }
  }

  /// Clear popular films list
  Future<DataState<bool>> clearListPopular() async {
    try {
      if (kDebugMode) {
        debugPrint('🧹 Clearing popular films list');
      }

      final success = await _hiveUtils.delete(_popularKey);

      return success
          ? DataState.success(data: true)
          : DataState.error(message: 'Failed to clear popular films');
    } catch (e) {
      debugPrint('❌ Error clearing popular films: $e');
      return DataState.error(
        message: 'Failed to clear popular films',
        exception: e,
      );
    }
  }

  /// Add now playing films list with deduplication
  Future<DataState<bool>> addListNowPlaying({
    required List<FilmModel> nowPlayingList,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('🎬 Adding ${nowPlayingList.length} now playing films');
      }

      final result = await getListNowPlaying();
      return result.when(
        success: (existingList) async {
          List<FilmModel> temp = List.from(existingList);

          // Add new films, avoiding duplicates
          for (var element in nowPlayingList) {
            if (!temp.any((e) => e.id == element.id)) {
              temp.add(element);
            }
          }

          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _nowPlayingKey,
            data: temp,
          );

          if (success && kDebugMode) {
            debugPrint(
              '✅ Stored ${temp.length} now playing films (${nowPlayingList.length} new)',
            );
          }

          return success
              ? DataState.success(data: true)
              : DataState.error(message: 'Failed to store now playing films');
        },
        error: (message, data, exception, stackTrace, statusCode) async {
          // If no existing data, create new list
          final success = await _hiveUtils.set<List<FilmModel>>(
            key: _nowPlayingKey,
            data: nowPlayingList,
          );

          return success
              ? DataState.success(data: true)
              : DataState.error(
                  message: 'Failed to create new now playing films list',
                );
        },
      );
    } catch (e) {
      debugPrint('❌ Error storing now playing films: $e');
      return DataState.error(
        message: 'Failed to store now playing films',
        exception: e,
      );
    }
  }

  /// Get now playing films list
  Future<DataState<List<FilmModel>>> getListNowPlaying() async {
    try {
      final result = _hiveUtils.get<List<FilmModel>>(key: _nowPlayingKey);

      if (result == null || result.isEmpty) {
        if (kDebugMode) {
          debugPrint('📭 Now playing films list is empty');
        }
        return DataState.success(data: <FilmModel>[]);
      }

      final films = result;

      if (kDebugMode) {
        debugPrint('📖 Retrieved ${films.length} now playing films');
      }

      return DataState.success(data: films);
    } catch (e) {
      debugPrint('❌ Error getting now playing films: $e');
      return DataState.error(
        message: 'Failed to retrieve now playing films',
        exception: e,
      );
    }
  }

  /// Clear now playing films list
  Future<DataState<bool>> clearListNowPlaying() async {
    try {
      if (kDebugMode) {
        debugPrint('🧹 Clearing now playing films list');
      }

      final success = await _hiveUtils.delete(_nowPlayingKey);

      return success
          ? DataState.success(data: true)
          : DataState.error(message: 'Failed to clear now playing films');
    } catch (e) {
      debugPrint('❌ Error clearing now playing films: $e');
      return DataState.error(
        message: 'Failed to clear now playing films',
        exception: e,
      );
    }
  }

  /// Get storage statistics
  Map<String, dynamic> getStorageStats() {
    return {
      'watchlistCount':
          _hiveUtils.get<List<dynamic>>(key: _watchlistKey)?.length ?? 0,
      'favoritesCount':
          _hiveUtils.get<List<dynamic>>(key: _favoriteKey)?.length ?? 0,
      'genresCount': _hiveUtils.get<List<dynamic>>(key: _genreKey)?.length ?? 0,
      'popularCount':
          _hiveUtils.get<List<dynamic>>(key: _popularKey)?.length ?? 0,
      'nowPlayingCount':
          _hiveUtils.get<List<dynamic>>(key: _nowPlayingKey)?.length ?? 0,
    };
  }

  /// Clear all cached data
  Future<DataState<bool>> clearAllCache() async {
    try {
      if (kDebugMode) {
        debugPrint('🧹 Clearing all cached data');
      }

      final keys = [_popularKey, _nowPlayingKey, _genreKey];
      final deletedCount = await _hiveUtils.deleteAll(keys);

      if (kDebugMode) {
        debugPrint('✅ Cleared $deletedCount cache entries');
      }

      return DataState.success(data: true);
    } catch (e) {
      debugPrint('❌ Error clearing cache: $e');
      return DataState.error(message: 'Failed to clear cache', exception: e);
    }
  }
}
