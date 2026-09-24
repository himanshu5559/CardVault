import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client_provider.dart';
import '../data/card_repository.dart';
import '../domain/card.dart';

final cardRepositoryProvider = Provider<CardRepository>((ref) {
  return CardRepository(ref.watch(apiClientProvider));
});

final cardProvider = AsyncNotifierProvider<CardNotifier, List<Card>>(
  CardNotifier.new,
);

class CardNotifier extends AsyncNotifier<List<Card>> {
  @override
  Future<List<Card>> build() async {
    return _loadCards();
  }

  Future<List<Card>> _loadCards() async {
    final repository = ref.read(cardRepositoryProvider);
    return repository.getCards();
  }

  Future<void> refreshCards() async {
    state = await AsyncValue.guard(_loadCards);
  }
}
