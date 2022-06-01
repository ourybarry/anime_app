import 'package:anime/resources/model/anime/poster_image.dart';
import 'package:deep_pick/deep_pick.dart';

class Anime {
  final String id;
  final Map<String, String?> titles;
  final String slug;
  final String canonicalTitle;
  final String? synopsis;
  final String? trailer;
  final PosterImage posterImage;
  final int popularity;
  final String? averageRating;
  final String? ageRatingGuide;
  final String? subType;

  Anime(
      {required this.id,
      required this.titles,
      this.synopsis,
      required this.slug,
      required this.canonicalTitle,
      required this.posterImage,
      this.trailer,
      required this.popularity,
      this.averageRating,
      this.ageRatingGuide,
      this.subType});

  factory Anime.fromPick(RequiredPick pick) {
    final String id = pick('id').asStringOrThrow();
    final Map<String, String?> titles = pick('titles').asMapOrThrow();
    final String slug = pick('slug').asStringOrThrow();
    final String canTitle = pick('canonicalTitle').asStringOrThrow();
    final PosterImage poster =
        pick('posterImage').letOrThrow((pick) => PosterImage.fromPick(pick));
    final String? synopsis = pick('synopsis').asStringOrNull();
    final String? trailer = pick('youtubeVideoId').asStringOrNull();
    final int popularity = pick('popularityRank').asIntOrThrow();
    final String? rating = pick('averageRating').asStringOrNull();
    final String? ageRatingGuide = pick('ageRatingGuide').asStringOrNull();
    final String? subType = pick('subtype').asStringOrNull();
    return Anime(
        id: id,
        titles: titles,
        slug: slug,
        canonicalTitle: canTitle,
        synopsis: synopsis,
        posterImage: poster,
        trailer: trailer,
        popularity: popularity,
        averageRating: rating,
        ageRatingGuide: ageRatingGuide,
        subType: subType);
  }
}
