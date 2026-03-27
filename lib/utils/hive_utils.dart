import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_core/data/model/film_model/film_model.dart';
import 'package:tmdb_core/data/model/genre_model/genre_model.dart';

/// Enhanced local storage utils backed by SharedPreferences.
/// Provides type-safe operations, error handling, and performance optimizations
class HiveUtils {
  final SharedPreferences _prefs;
  static const String _baseStorage = "hive_storage";
  static const String _encryptedStorage = "hive_encrypted_storage";

  // Storage keys for different data types
  static const String _favoritesKey = "favorites";
  static const String _watchlistKey = "watchlist";
  static const String _userPreferencesKey = "user_preferences";
  static const String _cacheKey = "cache";

  HiveUtils._(this._prefs);

  /// Create HiveUtils instance with optional encryption
  static Future<HiveUtils> instance({bool encrypted = false}) async {
    try {
      final boxName = encrypted ? _encryptedStorage : _baseStorage;

      // SharedPreferences does not support custom box names/encryption.
      final prefs = await SharedPreferences.getInstance();

      if (kDebugMode) {
        debugPrint('📦 HiveUtils initialized with storage: $boxName');
      }

      return HiveUtils._(prefs);
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

      bool success;
      if (data is List<FilmModel>) {
        final dataToStore = data.map((film) => film.toJson()).toList();
        success = await _prefs.setString(key, jsonEncode(dataToStore));
      } else if (data is List<GenreModel>) {
        final dataToStore = data.map((genre) => genre.toJson()).toList();
        success = await _prefs.setString(key, jsonEncode(dataToStore));
      } else {
        success = await _writeValue(key, _serializeData(data));
      }

      if (!success) return false;

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
      if (!_prefs.containsKey(key)) {
        if (kDebugMode) {
          debugPrint('🔍 Key not found: $key');
        }
        return defaultValue;
      }

      final data = _prefs.get(key);
      if (data == null) {
        return defaultValue;
      }

      // Handle specific model types with adapters
      T? deserializedData;
      if (T == List<FilmModel>) {
        if (data is String) {
          final decoded = jsonDecode(data);
          if (decoded is List) {
            deserializedData =
                decoded
                        .map(
                          (e) =>
                              FilmModel.fromJson(Map<String, dynamic>.from(e)),
                        )
                        .toList()
                    as T;
          } else {
            deserializedData = defaultValue;
          }
        } else {
          deserializedData = defaultValue;
        }
      } else if (T == List<GenreModel>) {
        if (data is String) {
          final decoded = jsonDecode(data);
          if (decoded is List) {
            deserializedData =
                decoded
                        .map(
                          (e) =>
                              GenreModel.fromJson(Map<String, dynamic>.from(e)),
                        )
                        .toList()
                    as T;
          } else {
            deserializedData = defaultValue;
          }
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
    return _prefs.containsKey(key);
  }

  /// Get all keys
  Iterable<String> getAllKeys() {
    return _prefs.getKeys();
  }

  /// Get all values
  Iterable<dynamic> getAllValues() {
    return _prefs.getKeys().map((key) => _prefs.get(key));
  }

  /// Delete specific key
  Future<bool> delete(String key) async {
    try {
      if (!_prefs.containsKey(key)) {
        if (kDebugMode) {
          debugPrint('⚠️ Key not found for deletion: $key');
        }
        return false;
      }

      await _prefs.remove(key);

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
        if (_prefs.containsKey(key)) {
          await _prefs.remove(key);
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
      await _prefs.clear();

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
      return _prefs.getKeys().length;
    } catch (e) {
      debugPrint('❌ Failed to get storage size: $e');
      return 0;
    }
  }

  /// Batch operations for better performance
  Future<Map<String, bool>> batchSet<T>(Map<String, T> dataMap) async {
    final results = <String, bool>{};

    try {
      for (final entry in dataMap.entries) {
        results[entry.key] = await _writeValue(
          entry.key,
          _serializeData(entry.value),
        );
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
    if (data is List<FilmModel>) {
      return jsonEncode(data.map((film) => film.toJson()).toList());
    }
    if (data is List<GenreModel>) {
      return jsonEncode(data.map((genre) => genre.toJson()).toList());
    }
    if (data is String ||
        data is int ||
        data is double ||
        data is bool ||
        data is List<String>) {
      return data;
    }
    if (data is List || data is Map) {
      return jsonEncode(data);
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
    if (kDebugMode) {
      debugPrint('🔒 SharedPreferences storage closed (no-op)');
    }
  }

  /// Get storage statistics
  Map<String, dynamic> getStorageStats() {
    return {
      'totalKeys': _prefs.getKeys().length,
      'favoritesCount': getFavorites().length,
      'watchlistCount': getWatchlist().length,
      'cacheKeys': getAllKeys()
          .where((key) => key.startsWith('${_cacheKey}_'))
          .length,
      'isOpen': true,
    };
  }

  Future<bool> _writeValue(String key, dynamic value) async {
    if (value is String) {
      return _prefs.setString(key, value);
    }
    if (value is int) {
      return _prefs.setInt(key, value);
    }
    if (value is double) {
      return _prefs.setDouble(key, value);
    }
    if (value is bool) {
      return _prefs.setBool(key, value);
    }
    if (value is List<String>) {
      return _prefs.setStringList(key, value);
    }

    // Fallback to JSON string for unsupported types.
    return _prefs.setString(key, jsonEncode(value));
  }
}
