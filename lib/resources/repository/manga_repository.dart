import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/model/category/category.dart';
import 'package:anime/resources/model/manga/manga_result.dart';

class MangaRepository {
  final ApiClient _client = ApiClient();

  Future<MangaResult> getByQuery(String query) async {
    const String path = '/manga/autocomplete';
    final params = {'query': query};
    final result = await _client.get(path, params: params);

    return MangaResult.fromJson(result);
  }

  Future<MangaResult> getTrending() async {
    const String path = '/manga/trending';

    final result = await _client.get(path);

    return MangaResult.fromJson(result);
  }

  Future<MangaResult> getByCategory(
      {required Category category, int? page = 0, int? limit = 20}) async {
    // print('fetching');
    String path = '/manga/' + category.slug;
    final params = {'page': page.toString(), 'limit': limit.toString()};
    final result = await _client.get(path, params: params);

    // print(result);

    return MangaResult.fromJson(result);
  }
}
