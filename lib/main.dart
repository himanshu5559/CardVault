import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/presentation/login_screen.dart';
import 'features/cards/domain/card.dart' as domain;
import 'features/cards/presentation/card_detail_screen.dart';
import 'features/cards/presentation/card_wallet_screen.dart';

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardWalletScreen(),
    ),
    GoRoute(
      path: '/cards/:id',
      builder: (context, state) {
        final card = state.extra;
        if (card is! domain.Card) {
          return const Scaffold(
            body: Center(child: Text('Card details are unavailable.')),
          );
        }

        return CardDetailScreen(card: card);
      },
    ),
  ],
);

void main() {
  runApp(const ProviderScope(child: CardVaultApp()));
}

class CardVaultApp extends StatelessWidget {
  const CardVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CardVault',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
