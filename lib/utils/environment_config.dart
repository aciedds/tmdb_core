/// Secure environment configuration manager
/// Handles loading and accessing environment variables
class EnvironmentConfig {
  static bool _isInitialized = false;
  static String _baseUrl = '';
  static String _apiKey = '';
  static String _imageBaseUrl = '';
  static String _largeImageBaseUrl = '';
  static String _appName = '';
  static String _appVersion = '';
  static bool _debugMode = false;

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

    try {
      _baseUrl = baseUrl;
      _apiKey = apiKey;
      _imageBaseUrl = imageBaseUrl;
      _largeImageBaseUrl = largeImageBaseUrl;
      _appName = appName;
      _appVersion = appVersion;
      _debugMode = debugMode;
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to load environment configuration: $e');
    }
  }

  /// Get TMDB API Base URL
  static String get baseUrl {
    _checkInitialized();
    return _baseUrl;
  }

  /// Get TMDB API Key
  static String get apiKey {
    _checkInitialized();
    return _apiKey;
  }

  /// Get TMDB Image Base URL
  static String get imageBaseUrl {
    _checkInitialized();
    return _imageBaseUrl;
  }

  /// Get TMDB Large Image Base URL
  static String get largeImageBaseUrl {
    _checkInitialized();
    return _largeImageBaseUrl;
  }

  /// Get App Name
  static String get appName {
    _checkInitialized();
    return _appName;
  }

  /// Get App Version
  static String get appVersion {
    _checkInitialized();
    return _appVersion;
  }

  /// Check if debug mode is enabled
  static bool get isDebugMode {
    _checkInitialized();
    return _debugMode == 'true';
  }

  /// Validate all required environment variables
  static void validate() {
    _checkInitialized();

    final requiredVars = [
      'TMDB_BASE_URL',
      'TMDB_API_KEY',
      'TMDB_IMAGE_BASE_URL',
      'TMDB_LARGE_IMAGE_BASE_URL',
    ];

    for (final varName in requiredVars) {
      if (varName.isEmpty) {
        throw Exception('Required environment variable $varName is not set');
      }
    }
  }

  /// Check if environment is properly initialized
  static void _checkInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'EnvironmentConfig not initialized. Call initialize() first.',
      );
    }
  }

  /// Get all environment variables (for debugging purposes only)
  static Map<String, String> getAllVars() {
    _checkInitialized();
    return {
      'baseUrl': _baseUrl,
      'apiKey': _apiKey,
      'imageBaseUrl': _imageBaseUrl,
      'largeImageBaseUrl': _largeImageBaseUrl,
      'appName': _appName,
      'appVersion': _appVersion,
      'debugMode': _debugMode ? 'true' : 'false',
    };
  }

  /// Check if running in production
  static bool get isProduction {
    _checkInitialized();
    return !isDebugMode;
  }
}
