import 'package:flutter/material.dart';

import '../domain/card.dart' as domain;

class CardDetailScreen extends StatelessWidget {
  final domain.Card card;

  const CardDetailScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Details')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow(label: 'Network', value: card.network),
            _DetailRow(label: 'Card number', value: card.maskedNumber),
            _DetailRow(label: 'Expiry', value: card.expiry),
            _DetailRow(label: 'Status', value: _statusLabel(card.status)),
          ],
        ),
      ),
    );
  }

  String _statusLabel(domain.CardStatus status) {
    return switch (status) {
      domain.CardStatus.active => 'Active',
      domain.CardStatus.frozen => 'Frozen',
      domain.CardStatus.blocked => 'Blocked',
    };
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
