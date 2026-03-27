import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_core/utils/api_constants.dart';
import 'package:tmdb_core/utils/environment_config.dart';

/// Dio HTTP Client Configuration
/// Handles API requests with proper authentication and error handling
class DioUtils {
  const DioUtils._();

  /// Create and configure Dio client
  static Future<Dio> client() async {
    // Ensure environment is initialized
    await EnvironmentConfig.initialize(
      baseUrl: ApiConstants.baseUrl,
      apiKey: ApiConstants.apiKey,
      imageBaseUrl: ApiConstants.imageBaseUrl,
      largeImageBaseUrl: ApiConstants.largeImageBaseUrl,
      appName: ApiConstants.appName,
      appVersion: ApiConstants.appVersion,
      debugMode: ApiConstants.isDebugMode,
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // Add request interceptor for API key
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add API key to all requests
          options.queryParameters[ApiConstants.apiKeyParam] =
              ApiConstants.apiKey;

          // Add default language if not specified
          if (!options.queryParameters.containsKey(
            ApiConstants.languageParam,
          )) {
            options.queryParameters[ApiConstants.languageParam] =
                ApiConstants.defaultLanguage;
          }

          // Add default page if not specified
          if (!options.queryParameters.containsKey(ApiConstants.pageParam)) {
            options.queryParameters[ApiConstants.pageParam] = ApiConstants
                .defaultPage
                .toString();
          }

          // Add include_adult parameter
          if (!options.queryParameters.containsKey(
            ApiConstants.includeAdultParam,
          )) {
            options.queryParameters[ApiConstants.includeAdultParam] =
                ApiConstants.defaultIncludeAdult.toString();
          }

          // Log request in debug mode
          if (ApiConstants.isDebugMode) {
            debugPrint('🚀 API Request: ${options.method} ${options.uri}');
            debugPrint('📋 Query Parameters: ${options.queryParameters}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response in debug mode
          if (ApiConstants.isDebugMode) {
            debugPrint(
              '✅ API Response: ${response.statusCode} ${response.requestOptions.uri}',
            );
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          // Log error in debug mode
          if (ApiConstants.isDebugMode) {
            debugPrint(
              '❌ API Error: ${error.response?.statusCode} ${error.requestOptions.uri}',
            );
            debugPrint('📝 Error Message: ${error.message}');
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  /// Create Dio client with custom configuration
  static Future<Dio> clientWithConfig({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? additionalHeaders,
  }) async {
    await EnvironmentConfig.initialize(
      baseUrl: ApiConstants.baseUrl,
      apiKey: ApiConstants.apiKey,
      imageBaseUrl: ApiConstants.imageBaseUrl,
      largeImageBaseUrl: ApiConstants.largeImageBaseUrl,
      appName: ApiConstants.appName,
      appVersion: ApiConstants.appVersion,
      debugMode: ApiConstants.isDebugMode,
    );

    if (ApiConstants.isDebugMode) {
      debugPrint(
        '🚀 Dio client initialized with config: ${EnvironmentConfig.getAllVars()}',
      );
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?additionalHeaders,
        },
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        sendTimeout: sendTimeout ?? const Duration(seconds: 30),
      ),
    );

    // Add the same interceptors as the default client
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters[ApiConstants.apiKeyParam] =
              ApiConstants.apiKey;
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}
