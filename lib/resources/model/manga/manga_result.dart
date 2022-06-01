import 'package:anime/resources/model/manga/manga.dart';
import 'package:deep_pick/deep_pick.dart';

class MangaResult {
  final List<Manga> data;

  MangaResult({required this.data});

  factory MangaResult.fromJson(Map<String, dynamic> json) {
    final List<Manga> data =
        pick(json, 'data').asListOrEmpty((p0) => Manga.fromPick(p0));
    return MangaResult(data: data);
  }
}
