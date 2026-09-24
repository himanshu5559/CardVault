enum CardStatus { active, frozen, blocked }

class Card {
  final String id;
  final String network;
  final String maskedNumber;
  final String expiry;
  final CardStatus status;

  const Card({
    required this.id,
    required this.network,
    required this.maskedNumber,
    required this.expiry,
    required this.status,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] as String,
      network: json['network'] as String,
      maskedNumber: json['maskedNumber'] as String,
      expiry: json['expiry'] as String,
      status: CardStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => CardStatus.active,
      ),
    );
  }
}
