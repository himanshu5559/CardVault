import 'package:flutter_test/flutter_test.dart';

import 'package:cardvault/core/storage/secure_storage.dart';

class FakeSecureStorage implements SecureStorageClient {
  final Map<String, String> _data = {};

  @override
  Future<void> write({required String key, required String value}) async {
    _data[key] = value;
  }

  @override
  Future<String?> read({required String key}) async {
    return _data[key];
  }

  @override
  Future<void> delete({required String key}) async {
    _data.remove(key);
  }
}

void main() {
  group('SecureStorage', () {
    test('writes, reads, and deletes a value', () async {
      final fakeStorage = FakeSecureStorage();

      final storage = SecureStorage(storage: fakeStorage);

      await storage.write(key: 'test_key', value: 'test_value');

      final value = await storage.read(key: 'test_key');

      expect(value, 'test_value');

      await storage.delete(key: 'test_key');

      final deletedValue = await storage.read(key: 'test_key');

      expect(deletedValue, isNull);
    });
  });
}
