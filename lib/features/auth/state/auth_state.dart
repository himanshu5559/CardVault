import '../domain/session.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState {
  final AuthStatus status;
  final Session? session;

  const AuthState({
    required this.status,
    this.session,
  });

  bool get isAuthenticated {
    return status == AuthStatus.authenticated;
  }
}