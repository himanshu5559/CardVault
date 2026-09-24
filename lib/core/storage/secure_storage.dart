import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class SecureStorageClient {
  Future<void> write({required String key, required String value});

  Future<String?> read({required String key});

  Future<void> delete({required String key});
}

class FlutterSecureStorageClient implements SecureStorageClient {
  final FlutterSecureStorage _storage;

  const FlutterSecureStorageClient({
    this._storage = const FlutterSecureStorage(),
  });

  @override
  Future<void> write({required String key, required String value}) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }
}

class SecureStorage implements SecureStorageClient {
  final SecureStorageClient _storage;

  const SecureStorage({this._storage = const FlutterSecureStorageClient()});

  @override
  Future<void> write({required String key, required String value}) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }
}
