import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/model/anime/anime_result.dart';
import 'package:anime/resources/model/category/category.dart';

class AnimeRepository {
  final ApiClient _client = ApiClient();

  Future<AnimeResult> getByQuery(String query) async {
    const String path = '/anime/autocomplete';
    final params = {'query': query};
    final result = await _client.get(path, params);

    return AnimeResult.fromJson(result);
  }

  Future<AnimeResult> getByCategory(
      {required Category category, int? page = 0, int? limit = 20}) async {
    // print('fetching');
    String path = '/anime/' + category.slug;
    final params = {'page': page.toString(), 'limit': limit.toString()};
    final result = await _client.get(path, params);

    // print(result);

    return AnimeResult.fromJson(result);
  }

  Future<AnimeResult> getTrending() async {
    const String path = '/anime/trending';

    final result = await _client.get(path, null);

    return AnimeResult.fromJson(result);
  }
}
