import 'package:anime/resources/model/anime/anime.dart';
import 'package:anime/resources/model/item.dart';
import 'package:deep_pick/deep_pick.dart';

class Result<T extends Item> {
  final List<T> data;

  Result({required this.data});

  // factory Result.fromJson(Map<String, dynamic> json) {
  //   final List<T> data =
  //       pick(json, 'data').asListOrEmpty((p0) => T.fromPick(p0));
  //   return Result(data: data);
  // }
}
