sealed class BankError implements Exception {
  final String message;
  final String? code;
  final String? traceId;

  const BankError({
    required this.message,
    this.code,
    this.traceId,
  });
}

final class NetworkBankError extends BankError {
  const NetworkBankError({
    super.message = 'Unable to connect. Please check your internet connection.',
    super.code,
    super.traceId,
  });
}

final class UnauthorizedBankError extends BankError {
  const UnauthorizedBankError({
    super.message = 'Your session has expired. Please log in again.',
    super.code,
    super.traceId,
  });
}

final class ForbiddenBankError extends BankError {
  const ForbiddenBankError({
    super.message = 'You are not allowed to perform this action.',
    super.code,
    super.traceId,
  });
}

final class NotFoundBankError extends BankError {
  const NotFoundBankError({
    super.message = 'The requested resource was not found.',
    super.code,
    super.traceId,
  });
}

final class ConflictBankError extends BankError {
  const ConflictBankError({
    super.message = 'The request conflicts with the current state.',
    super.code,
    super.traceId,
  });
}

final class ValidationBankError extends BankError {
  const ValidationBankError({
    super.message = 'Some of the provided information is invalid.',
    super.code,
    super.traceId,
  });
}

final class ServerBankError extends BankError {
  const ServerBankError({
    super.message = 'Something went wrong on the server.',
    super.code,
    super.traceId,
  });
}

final class UnknownBankError extends BankError {
  const UnknownBankError({
    super.message = 'Something went wrong. Please try again.',
    super.code,
    super.traceId,
  });
}