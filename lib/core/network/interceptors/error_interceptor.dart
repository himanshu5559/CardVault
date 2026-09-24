import 'package:dio/dio.dart';

import '../../errors/bank_error.dart';

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: const UnauthorizedBankError(),
          message: 'Unauthorized request.',
        ),
      );
      return;
    }

    handler.next(err);
  }
}
