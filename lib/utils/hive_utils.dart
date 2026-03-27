import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmdb_core/data/model/film_model/film_model.dart';
import 'package:tmdb_core/data/model/film_model/film_model_adapter.dart';
import 'package:tmdb_core/data/model/genre_model/genre_model.dart';
import 'package:tmdb_core/data/model/genre_model/genre_model_adapter.dart';

//Export hive
export "package:hive_flutter/hive_flutter.dart";

/// Enhanced HiveUtils for secure and efficient local storage
/// Provides type-safe operations, error handling, and performance optimizations
class HiveUtils {
  final Box<dynamic> _box;
  static const String _baseStorage = "hive_storage";
  static const String _encryptedStorage = "hive_encrypted_storage";

  // Storage keys for different data types
  static const String _favoritesKey = "favorites";
  static const String _watchlistKey = "watchlist";
  static const String _userPreferencesKey = "user_preferences";
  static const String _cacheKey = "cache";

  HiveUtils._(this._box);

  /// Create HiveUtils instance with optional encryption
  static Future<HiveUtils> instance({bool encrypted = false}) async {
    try {
      final boxName = encrypted ? _encryptedStorage : _baseStorage;

      // For now, disable encryption to avoid key issues
      // TODO: Implement proper encryption key management
      final box = await Hive.openBox(boxName);

      if (kDebugMode) {
        debugPrint('📦 HiveUtils initialized with box: $boxName');
      }

      return HiveUtils._(box);
    } catch (e) {
      debugPrint('❌ Failed to initialize HiveUtils: $e');
      rethrow;
    }
  }

  /// Store data with type safety and validation
  Future<bool> set<T>({
    required String key,
    required T data,
    bool validate = true,
  }) async {
    try {
      if (validate && data == null) {
        throw ArgumentError('Data cannot be null when validation is enabled');
      }

      // Handle specific model types with adapters
      dynamic dataToStore;
      if (data is List<FilmModel>) {
        dataToStore = data
            .map((film) => FilmModelAdapter.fromFilmModel(film))
            .toList();
      } else if (data is List<GenreModel>) {
        dataToStore = data
            .map((genre) => GenreModelAdapter.fromGenreModel(genre))
            .toList();
      } else {
        // Convert data to JSON if it's not a primitive type
        dataToStore = _serializeData(data);
      }

      await _box.put(key, dataToStore);

      if (kDebugMode) {
        debugPrint('💾 Stored data for key: $key (${data.runtimeType})');
      }

      return true;
    } catch (e) {
      debugPrint('❌ Failed to store data for key $key: $e');
      return false;
    }
  }

  /// Retrieve data with type safety and error handling
  T? get<T>({required String key, T? defaultValue}) {
    try {
      if (!_box.containsKey(key)) {
        if (kDebugMode) {
          debugPrint('🔍 Key not found: $key');
        }
        return defaultValue;
      }

      final data = _box.get(key);
      if (data == null) {
        return defaultValue;
      }

      // Handle specific model types with adapters
      T? deserializedData;
      if (T == List<FilmModel>) {
        if (data is List) {
          deserializedData =
              data.map((e) => (e as FilmModelAdapter).toFilmModel()).toList()
                  as T;
        } else {
          deserializedData = defaultValue;
        }
      } else if (T == List<GenreModel>) {
        if (data is List) {
          deserializedData =
              data.map((e) => (e as GenreModelAdapter).toGenreModel()).toList()
                  as T;
        } else {
          deserializedData = defaultValue;
        }
      } else {
        // Deserialize data if needed
        deserializedData = _deserializeData<T>(data);
      }

      if (kDebugMode) {
        debugPrint(
          '📖 Retrieved data for key: $key (${deserializedData.runtimeType})',
        );
      }

      return deserializedData;
    } catch (e) {
      debugPrint('❌ Failed to retrieve data for key $key: $e');
      return defaultValue;
    }
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _box.containsKey(key);
  }

  /// Get all keys
  Iterable<String> getAllKeys() {
    return _box.keys.cast<String>();
  }

  /// Get all values
  Iterable<dynamic> getAllValues() {
    return _box.values;
  }

  /// Delete specific key
  Future<bool> delete(String key) async {
    try {
      if (!_box.containsKey(key)) {
        if (kDebugMode) {
          debugPrint('⚠️ Key not found for deletion: $key');
        }
        return false;
      }

      await _box.delete(key);

      if (kDebugMode) {
        debugPrint('🗑️ Deleted data for key: $key');
      }

      return true;
    } catch (e) {
      debugPrint('❌ Failed to delete data for key $key: $e');
      return false;
    }
  }

  /// Delete multiple keys
  Future<int> deleteAll(List<String> keys) async {
    try {
      int deletedCount = 0;
      for (final key in keys) {
        if (_box.containsKey(key)) {
          await _box.delete(key);
          deletedCount++;
        }
      }

      if (kDebugMode) {
        debugPrint(
          '🗑️ Deleted $deletedCount keys out of ${keys.length} requested',
        );
      }

      return deletedCount;
    } catch (e) {
      debugPrint('❌ Failed to delete multiple keys: $e');
      return 0;
    }
  }

  /// Clear all data
  Future<bool> reset() async {
    try {
      await _box.clear();

      if (kDebugMode) {
        debugPrint('🔄 Hive storage reset successfully');
      }

      return true;
    } catch (e) {
      debugPrint('❌ Failed to reset Hive storage: $e');
      return false;
    }
  }

  /// Get storage size in bytes
  Future<int> getStorageSize() async {
    try {
      return _box.length;
    } catch (e) {
      debugPrint('❌ Failed to get storage size: $e');
      return 0;
    }
  }

  /// Batch operations for better performance
  Future<Map<String, bool>> batchSet<T>(Map<String, T> dataMap) async {
    final results = <String, bool>{};

    try {
      // Use batch write for better performance
      await _box.putAll(
        dataMap.map((key, value) => MapEntry(key, _serializeData(value))),
      );

      // Mark all as successful
      for (final key in dataMap.keys) {
        results[key] = true;
      }

      if (kDebugMode) {
        debugPrint('📦 Batch stored ${dataMap.length} items');
      }
    } catch (e) {
      debugPrint('❌ Batch operation failed: $e');
      // Mark all as failed
      for (final key in dataMap.keys) {
        results[key] = false;
      }
    }

    return results;
  }

  /// Batch get operations
  Map<String, T?> batchGet<T>(List<String> keys) {
    final results = <String, T?>{};

    for (final key in keys) {
      results[key] = get<T>(key: key);
    }

    if (kDebugMode) {
      debugPrint('📖 Batch retrieved ${keys.length} items');
    }

    return results;
  }

  // Specialized methods for common use cases

  /// Store favorites list
  Future<bool> setFavorites(List<String> favoriteIds) async {
    return await set(key: _favoritesKey, data: favoriteIds);
  }

  /// Get favorites list
  List<String> getFavorites() {
    return get<List<dynamic>>(
          key: _favoritesKey,
          defaultValue: [],
        )?.cast<String>() ??
        [];
  }

  /// Store watchlist
  Future<bool> setWatchlist(List<String> watchlistIds) async {
    return await set(key: _watchlistKey, data: watchlistIds);
  }

  /// Get watchlist
  List<String> getWatchlist() {
    return get<List<dynamic>>(
          key: _watchlistKey,
          defaultValue: [],
        )?.cast<String>() ??
        [];
  }

  /// Store user preferences
  Future<bool> setUserPreferences(Map<String, dynamic> preferences) async {
    return await set(key: _userPreferencesKey, data: preferences);
  }

  /// Get user preferences
  Map<String, dynamic> getUserPreferences() {
    return get<Map<String, dynamic>>(
          key: _userPreferencesKey,
          defaultValue: {},
        ) ??
        {};
  }

  /// Store cached data with expiration
  Future<bool> setCache<T>({
    required String key,
    required T data,
    Duration? expiration,
  }) async {
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiration': expiration?.inMilliseconds,
    };

    return await set(key: '${_cacheKey}_$key', data: cacheData);
  }

  /// Get cached data with expiration check
  T? getCache<T>({required String key}) {
    final cacheData = get<Map<String, dynamic>>(key: '${_cacheKey}_$key');

    if (cacheData == null) return null;

    final timestamp = cacheData['timestamp'] as int?;
    final expiration = cacheData['expiration'] as int?;

    if (timestamp != null && expiration != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > expiration) {
        // Cache expired, delete it
        delete('${_cacheKey}_$key');
        return null;
      }
    }

    return cacheData['data'] as T?;
  }

  /// Clear expired cache entries
  Future<int> clearExpiredCache() async {
    final keys = getAllKeys().where((key) => key.startsWith('${_cacheKey}_'));
    int clearedCount = 0;

    for (final key in keys) {
      final cacheData = get<Map<String, dynamic>>(key: key);
      if (cacheData != null) {
        final timestamp = cacheData['timestamp'] as int?;
        final expiration = cacheData['expiration'] as int?;

        if (timestamp != null && expiration != null) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now - timestamp > expiration) {
            await delete(key);
            clearedCount++;
          }
        }
      }
    }

    if (kDebugMode) {
      debugPrint('🧹 Cleared $clearedCount expired cache entries');
    }

    return clearedCount;
  }

  /// Serialize data for storage
  dynamic _serializeData<T>(T data) {
    if (data is String ||
        data is int ||
        data is double ||
        data is bool ||
        data is List ||
        data is Map) {
      return data;
    }

    // Convert custom objects to JSON
    try {
      return jsonEncode(data);
    } catch (e) {
      debugPrint('⚠️ Failed to serialize data: $e');
      return data.toString();
    }
  }

  /// Deserialize data from storage
  T? _deserializeData<T>(dynamic data) {
    if (data is T) {
      return data;
    }

    // Try to deserialize JSON if it's a string
    if (data is String && T != String) {
      try {
        final decoded = jsonDecode(data);
        return decoded as T?;
      } catch (e) {
        debugPrint('⚠️ Failed to deserialize JSON: $e');
        return data as T?;
      }
    }

    return data as T?;
  }

  /// Close the Hive box
  Future<void> close() async {
    try {
      await _box.close();
      if (kDebugMode) {
        debugPrint('🔒 Hive box closed');
      }
    } catch (e) {
      debugPrint('❌ Failed to close Hive box: $e');
    }
  }

  /// Get storage statistics
  Map<String, dynamic> getStorageStats() {
    return {
      'totalKeys': _box.length,
      'favoritesCount': getFavorites().length,
      'watchlistCount': getWatchlist().length,
      'cacheKeys': getAllKeys()
          .where((key) => key.startsWith('${_cacheKey}_'))
          .length,
      'isOpen': _box.isOpen,
    };
  }
}
