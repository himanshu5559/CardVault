import 'package:flutter_test/flutter_test.dart';

import 'package:cardvault/features/cards/domain/card.dart';

void main() {
  test('Card.fromJson parses card fields and active status', () {
    final card = Card.fromJson({
      'id': 'card-1',
      'network': 'VISA',
      'maskedNumber': '•••• 4521',
      'expiry': '08/29',
      'status': 'active',
    });

    expect(card.id, 'card-1');
    expect(card.network, 'VISA');
    expect(card.maskedNumber, '•••• 4521');
    expect(card.expiry, '08/29');
    expect(card.status, CardStatus.active);
  });

  test('Card.fromJson parses frozen and blocked statuses', () {
    expect(
      Card.fromJson({
        'id': '1',
        'network': 'VISA',
        'maskedNumber': 'x',
        'expiry': 'x',
        'status': 'frozen',
      }).status,
      CardStatus.frozen,
    );
    expect(
      Card.fromJson({
        'id': '2',
        'network': 'VISA',
        'maskedNumber': 'x',
        'expiry': 'x',
        'status': 'blocked',
      }).status,
      CardStatus.blocked,
    );
  });
}
