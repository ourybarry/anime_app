import 'package:anime/resources/model/anime/anime.dart';
import 'package:deep_pick/deep_pick.dart';

class AnimeResult {
  final List<Anime> data;

  AnimeResult({required this.data});

  factory AnimeResult.fromJson(Map<String, dynamic> json) {
    final List<Anime> data =
        pick(json, 'data').asListOrEmpty((p0) => Anime.fromPick(p0));
    return AnimeResult(data: data);
  }
}
