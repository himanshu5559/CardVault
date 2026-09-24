import 'package:dio/dio.dart';

import 'bank_error.dart';

class ErrorMapper {
  const ErrorMapper();

  BankError map(Object error) {
    if (error is DioException) {
      return _mapDioException(error);
    }

    if (error is BankError) {
      return error;
    }

    return const UnknownBankError();
  }

  BankError _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.transformTimeout:
        return const NetworkBankError();

      case DioExceptionType.badResponse:
        return _mapStatusCode(error.response);

      case DioExceptionType.cancel:
        return const UnknownBankError(message: 'The request was cancelled.');

      case DioExceptionType.badCertificate:
        return const NetworkBankError(
          message: 'A secure connection could not be established.',
        );

      case DioExceptionType.unknown:
        return const UnknownBankError();
    }
  }

  BankError _mapStatusCode(Response<dynamic>? response) {
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 401:
        return const UnauthorizedBankError();

      case 403:
        return const ForbiddenBankError();

      case 404:
        return const NotFoundBankError();

      case 409:
        return const ConflictBankError();

      case 400:
      case 422:
        return const ValidationBankError();

      case 500:
      case 502:
      case 503:
      case 504:
        return const ServerBankError();

      default:
        return const UnknownBankError();
    }
  }
}
