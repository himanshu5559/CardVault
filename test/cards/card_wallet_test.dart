import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:cardvault/core/network/api_client.dart';
import 'package:cardvault/features/cards/data/card_repository.dart';
import 'package:cardvault/features/cards/domain/card.dart' as domain;
import 'package:cardvault/features/cards/presentation/card_detail_screen.dart';
import 'package:cardvault/features/cards/presentation/card_wallet_screen.dart';
import 'package:cardvault/features/cards/presentation/widgets/card_tile.dart';
import 'package:cardvault/features/cards/state/card_state.dart';

class _FakeCardRepository extends CardRepository {
  final Future<List<domain.Card>> Function() loader;

  _FakeCardRepository(this.loader) : super(ApiClient());

  @override
  Future<List<domain.Card>> getCards() => loader();
}

const _card = domain.Card(
  id: 'card-1',
  network: 'VISA',
  maskedNumber: '•••• 4521',
  expiry: '08/29',
  status: domain.CardStatus.active,
);

Widget _wallet(_FakeCardRepository repository) {
  return ProviderScope(
    overrides: [cardRepositoryProvider.overrideWithValue(repository)],
    child: const MaterialApp(home: CardWalletScreen()),
  );
}

void main() {
  testWidgets('wallet shows loading and then card data', (tester) async {
    final completer = Future<List<domain.Card>>.delayed(
      const Duration(milliseconds: 50),
      () => [_card],
    );
    await tester.pumpWidget(_wallet(_FakeCardRepository(() => completer)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('VISA'), findsOneWidget);
    expect(find.text('•••• 4521'), findsOneWidget);
  });

  testWidgets('wallet shows empty state', (tester) async {
    await tester.pumpWidget(_wallet(_FakeCardRepository(() async => [])));
    await tester.pumpAndSettle();

    expect(find.text('No cards available.'), findsOneWidget);
  });

  testWidgets('wallet shows error and retries', (tester) async {
    await tester.pumpWidget(
      _wallet(
        _FakeCardRepository(() async {
          throw Exception('load failed');
        }),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unable to load your cards.'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Unable to load your cards.'), findsOneWidget);
  });

  testWidgets('CardTile displays masked number and status', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CardTile(card: _card)),
      ),
    );

    expect(find.text('•••• 4521'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('tapping a wallet card navigates to card details', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/cards',
      routes: [
        GoRoute(
          path: '/cards',
          builder: (context, state) =>
              _wallet(_FakeCardRepository(() async => [_card])),
        ),
        GoRoute(
          path: '/cards/:id',
          builder: (context, state) =>
              CardDetailScreen(card: state.extra! as domain.Card),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    await tester.tap(find.text('•••• 4521'));
    await tester.pumpAndSettle();

    expect(find.text('Card Details'), findsOneWidget);
    expect(find.text('VISA'), findsOneWidget);
    expect(find.text('08/29'), findsOneWidget);
  });
}
