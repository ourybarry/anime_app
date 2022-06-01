import 'package:anime/resources/model/anime/poster_image.dart';
import 'package:deep_pick/deep_pick.dart';

class Character {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String slug;
  final String name;
  final int malId;
  final String? description;
  final PosterImage? image;

  Character(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.slug,
      required this.name,
      required this.malId,
      this.description,
      this.image});

  factory Character.fromPick(RequiredPick pick) {
    final String id = pick('id').asStringOrThrow();
    final DateTime? createdAt = pick('createdAt').asDateTimeOrNull();
    final DateTime? updatedAt = pick('updatedAt').asDateTimeOrNull();
    final String slug = pick('slug').asStringOrThrow();
    final String name = pick('name').asStringOrThrow();
    final int malId = pick('malId').asIntOrThrow();
    final String? description = pick('descriptions').asStringOrNull();
    final PosterImage? image =
        pick('image').letOrThrow((pick) => PosterImage.fromPick(pick));

    return Character(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        slug: slug,
        name: name,
        malId: malId,
        description: description,
        image: image);
  }
}
