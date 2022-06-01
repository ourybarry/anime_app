import 'package:anime/resources/model/category/category.dart';
import 'package:deep_pick/deep_pick.dart';

class CategoryResult {
  final List<Category> data;

  CategoryResult({required this.data});

  factory CategoryResult.fromJson(Map<String, dynamic> json) {
    final List<Category> data =
        pick(json, 'data').asListOrEmpty((p0) => Category.fromPick(p0));
    return CategoryResult(data: data);
  }
}
