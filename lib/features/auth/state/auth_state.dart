import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client_provider.dart';
import '../../../core/storage/secure_storage.dart';
import '../data/auth_repository.dart';
import '../domain/session.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final Session? session;

  const AuthState({required this.status, this.session});

  bool get isAuthenticated {
    return status == AuthStatus.authenticated;
  }
}

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(secureStorageProvider),
  );
});

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      final session = await repository.login(
        username: username,
        password: password,
      );

      return AuthState(status: AuthStatus.authenticated, session: session);
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      await repository.logout();

      return const AuthState(status: AuthStatus.unauthenticated);
    });
  }
}
