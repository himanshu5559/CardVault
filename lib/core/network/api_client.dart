import 'package:dio/dio.dart';

import '../config/api_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class ApiClient {
  final Dio dio;
  final AuthInterceptor authInterceptor;

  ApiClient({
    Dio? dio,
    AuthInterceptor? authInterceptor,
  })  : authInterceptor = authInterceptor ?? AuthInterceptor(),
        dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConfig.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                sendTimeout: const Duration(seconds: 10),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    this.dio.interceptors.addAll([
      this.authInterceptor,
      const LoggingInterceptor(),
      const ErrorInterceptor(),
    ]);
  }
}