import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cardvault/core/network/api_client.dart';
import 'package:cardvault/features/cards/data/card_repository.dart';
import 'package:cardvault/features/cards/domain/card.dart';

class _FakeAdapter implements HttpClientAdapter {
  final Object response;

  _FakeAdapter(this.response);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(response),
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

CardRepository _repository(Object response) {
  final dio = Dio()..httpClientAdapter = _FakeAdapter(response);
  return CardRepository(ApiClient(dio: dio));
}

void main() {
  test('CardRepository parses a successful cards response', () async {
    final cards = await _repository([
      {
        'id': 'card-1',
        'network': 'VISA',
        'maskedNumber': '•••• 4521',
        'expiry': '08/29',
        'status': 'active',
      },
    ]).getCards();

    expect(cards, hasLength(1));
    expect(cards.single.status, CardStatus.active);
  });

  test('CardRepository rejects a malformed response', () {
    expect(
      () => _repository({'cards': []}).getCards(),
      throwsA(isA<FormatException>()),
    );
  });
}
