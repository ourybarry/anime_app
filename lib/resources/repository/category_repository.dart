import 'package:anime/resources/api/client.dart';
import 'package:anime/resources/model/category/category_result.dart';

class CategoryRepository {
  final ApiClient _client = ApiClient();

  //Get some categories

  Future<CategoryResult> getCategories({int? page = 1, int? limit = 10}) async {
    const String path = '/categories';
    final params = {'page': page.toString(), 'limit': limit.toString()};
    final result = await _client.get(path, params: params);

    return CategoryResult.fromJson(result);
  }
}
