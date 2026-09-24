class Session {
  final String userId;
  final DateTime expiresAt;

  const Session({required this.userId, required this.expiresAt});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      userId: json['userId'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }
}
