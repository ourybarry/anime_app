import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/model/character/character_result.dart';

class CharacterRepository {
  final ApiClient _client = ApiClient();

  Future<CharacterResult> getByQuery(String query) async {
    const String path = '/character/autocomplete';
    final params = {'query': query};
    final result = await _client.get(path, params);

    return CharacterResult.fromJson(result);
  }
}
