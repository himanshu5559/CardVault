import 'dart:developer' as developer;

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    developer.log(
      '[API REQUEST] ${options.method} ${options.path}',
      name: 'CardVault.API',
    );

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    developer.log(
      '[API RESPONSE] ${response.statusCode} ${response.requestOptions.path}',
      name: 'CardVault.API',
    );

    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    developer.log(
      '[API ERROR] ${err.response?.statusCode ?? 'NO_STATUS'} '
      '${err.requestOptions.path}',
      name: 'CardVault.API',
    );

    handler.next(err);
  }
}