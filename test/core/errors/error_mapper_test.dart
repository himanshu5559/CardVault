import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cardvault/core/errors/bank_error.dart';
import 'package:cardvault/core/errors/error_mapper.dart';

void main() {
  group('ErrorMapper', () {
    test('maps connection error to NetworkBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
      );

      final result = mapper.map(error);

      expect(result, isA<NetworkBankError>());
    });

    test('maps 401 to UnauthorizedBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
      );

      final result = mapper.map(error);

      expect(result, isA<UnauthorizedBankError>());
    });

    test('maps 403 to ForbiddenBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 403,
        ),
      );

      final result = mapper.map(error);

      expect(result, isA<ForbiddenBankError>());
    });

    test('maps 404 to NotFoundBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
        ),
      );

      final result = mapper.map(error);

      expect(result, isA<NotFoundBankError>());
    });

    test('maps 409 to ConflictBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 409,
        ),
      );

      final result = mapper.map(error);

      expect(result, isA<ConflictBankError>());
    });

    test('maps 400 to ValidationBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
        ),
      );

      final result = mapper.map(error);

      expect(result, isA<ValidationBankError>());
    });

    test('maps 500 to ServerBankError', () {
      const mapper = ErrorMapper();

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );

      final result = mapper.map(error);

      expect(result, isA<ServerBankError>());
    });

    test('maps unknown exception to UnknownBankError', () {
      const mapper = ErrorMapper();

      final result = mapper.map(
        Exception('unexpected error'),
      );

      expect(result, isA<UnknownBankError>());
    });
  });
}