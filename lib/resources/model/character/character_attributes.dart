import 'package:anime/resources/model/anime/poster_image.dart';
import 'package:deep_pick/deep_pick.dart';

class CharacterAttributes {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String slug;
  final String name;
  final int malId;
  final String? description;
  final PosterImage image;

  CharacterAttributes(
      {this.createdAt,
      this.updatedAt,
      required this.slug,
      required this.name,
      required this.malId,
      this.description,
      required this.image});

  factory CharacterAttributes.fromPick(RequiredPick pick) {
    final DateTime? createdAt = pick('createdAt').asDateTimeOrNull();
    final DateTime? updatedAt = pick('updatedAt').asDateTimeOrNull();
    final String slug = pick('slug').asStringOrThrow();
    final String name = pick('name').asStringOrThrow();
    final int malId = pick('malId').asIntOrThrow();
    final String? description = pick('descriptions').asStringOrNull();
    final PosterImage image =
        pick('image').letOrThrow((pick) => PosterImage.fromPick(pick));

    return CharacterAttributes(
        createdAt: createdAt,
        updatedAt: updatedAt,
        slug: slug,
        name: name,
        malId: malId,
        description: description,
        image: image);
  }
}
