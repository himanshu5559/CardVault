import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../domain/card.dart';

class CardRepository {
  final ApiClient _apiClient;

  CardRepository(this._apiClient);

  Future<List<Card>> getCards() async {
    final response = await _apiClient.dio.get(ApiEndpoints.cards);

    final data = response.data;

    if (data is! List) {
      throw const FormatException('Invalid cards response');
    }

    return data
        .map((item) => Card.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
