import 'package:tmdb_core/utils/environment_config.dart';

/// API Constants - Now securely loaded from environment variables
class ApiConstants {
  ApiConstants._();

  /// TMDB API Base URL
  static String get baseUrl => EnvironmentConfig.baseUrl;

  /// TMDB API Key (securely loaded from environment)
  static String get apiKey => EnvironmentConfig.apiKey;

  /// TMDB Image Base URL for standard images
  static String get imageBaseUrl => EnvironmentConfig.imageBaseUrl;

  /// TMDB Large Image Base URL for high-quality images
  static String get largeImageBaseUrl => EnvironmentConfig.largeImageBaseUrl;

  /// App Name
  static String get appName => EnvironmentConfig.appName;

  /// App Version
  static String get appVersion => EnvironmentConfig.appVersion;

  /// Check if debug mode is enabled
  static bool get isDebugMode => EnvironmentConfig.isDebugMode;

  /// API Endpoints
  static const String nowPlayingEndpoint = '/movie/now_playing';
  static const String popularEndpoint = '/movie/popular';
  static const String topRatedEndpoint = '/movie/top_rated';
  static const String upcomingEndpoint = '/movie/upcoming';
  static const String searchEndpoint = '/search/movie';
  static const String movieDetailsEndpoint = '/movie';
  static const String similarMoviesEndpoint = '/movie/{id}/similar';
  static const String genresEndpoint = '/genre/movie/list';
  static const String movieVideosEndpoint = '/movie/{id}/videos';

  /// Image Sizes
  static const String imageSizeSmall = 'w200';
  static const String imageSizeMedium = 'w500';
  static const String imageSizeLarge = 'w780';
  static const String imageSizeOriginal = 'original';

  /// Request Parameters
  static const String apiKeyParam = 'api_key';
  static const String languageParam = 'language';
  static const String pageParam = 'page';
  static const String queryParam = 'query';
  static const String includeAdultParam = 'include_adult';

  /// Default Values
  static const String defaultLanguage = 'en-US';
  static const int defaultPage = 1;
  static const bool defaultIncludeAdult = false;
}
