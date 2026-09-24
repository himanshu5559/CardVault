import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/card_state.dart';
import 'widgets/card_tile.dart';

class CardWalletScreen extends ConsumerWidget {
  const CardWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(cardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Cards')),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Unable to load your cards.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(cardProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (cards) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(cardProvider.notifier).refreshCards();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 24),
              children: [
                if (cards.isEmpty)
                  const SizedBox(
                    height: 160,
                    child: Center(child: Text('No cards available.')),
                  )
                else
                  SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cards.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        return CardTile(
                          key: ValueKey(card.id),
                          card: card,
                          onTap: () =>
                              context.push('/cards/${card.id}', extra: card),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
