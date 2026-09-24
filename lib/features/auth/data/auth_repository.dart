import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/storage/secure_storage.dart';
import '../domain/session.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;

  AuthRepository(this._apiClient, this._secureStorage);

  Future<Session> login({
    required String username,
    required String password,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.login,
      data: {'username': username, 'password': password},
    );

    final data = response.data as Map<String, dynamic>;

    final accessToken = data['accessToken'] as String;
    final sessionData = data['session'] as Map<String, dynamic>;

    await _secureStorage.write(key: 'access_token', value: accessToken);

    _apiClient.authInterceptor.setAccessToken(accessToken);

    return Session.fromJson(sessionData);
  }

  Future<void> logout() async {
    try {
      await _apiClient.dio.post(ApiEndpoints.logout);
    } finally {
      _apiClient.authInterceptor.clearAccessToken();
      await _secureStorage.delete(key: 'access_token');
    }
  }
}
