import 'package:anime/resources/model/anime/poster_image.dart';
import 'package:deep_pick/deep_pick.dart';

class Manga {
  final Map<String, String?> titles;
  final String slug;
  final String canonicalTitle;
  final String? synopsis;
  final PosterImage posterImage;
  final int popularity;

  Manga(
      {required this.titles,
      this.synopsis,
      required this.slug,
      required this.canonicalTitle,
      required this.posterImage,
      required this.popularity});

  factory Manga.fromPick(RequiredPick pick) {
    final Map<String, String?> titles = pick('titles').asMapOrThrow();
    final String slug = pick('slug').asStringOrThrow();
    final String canTitle = pick('canonicalTitle').asStringOrThrow();
    final PosterImage poster =
        pick('posterImage').letOrThrow((pick) => PosterImage.fromPick(pick));
    final String? synopsis = pick('synopsis').asStringOrNull();
    final int popularity = pick('popularityRank').asIntOrThrow();

    return Manga(
        titles: titles,
        slug: slug,
        canonicalTitle: canTitle,
        synopsis: synopsis,
        posterImage: poster,
        popularity: popularity);
  }
}
