import 'package:flutter/material.dart';

import '../../domain/card.dart' as domain;

class CardTile extends StatelessWidget {
  final domain.Card card;
  final VoidCallback? onTap;

  const CardTile({super.key, required this.card, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isFrozen = card.status == domain.CardStatus.frozen;
    final isBlocked = card.status == domain.CardStatus.blocked;

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 320,
          height: 190,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.network,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  _StatusBadge(status: card.status),
                ],
              ),
              const Spacer(),
              Text(
                card.maskedNumber,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'Expires ${card.expiry}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (isFrozen || isBlocked) ...[
                const SizedBox(height: 4),
                Text(
                  isFrozen ? 'Card is frozen' : 'Card is blocked',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final domain.CardStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      domain.CardStatus.active => 'Active',
      domain.CardStatus.frozen => 'Frozen',
      domain.CardStatus.blocked => 'Blocked',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Text(label),
    );
  }
}
