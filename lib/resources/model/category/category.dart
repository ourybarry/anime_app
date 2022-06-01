import 'package:deep_pick/deep_pick.dart';

class Category {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String title;
  final String? description;
  final int totalMediaCount;
  final String slug;
  final bool nsfw;
  final int childCount;
  const Category(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.title,
      this.description,
      required this.totalMediaCount,
      required this.slug,
      required this.nsfw,
      required this.childCount});

  factory Category.fromPick(RequiredPick pick) {
    final String id = pick('id').asStringOrThrow();
    final DateTime? createdAt = pick('createdAt').asDateTimeOrNull();
    final DateTime? updatedAt = pick('updatedAt').asDateTimeOrNull();
    final String title = pick('title').asStringOrThrow();
    final String? description = pick('description').asStringOrNull();
    final int totalMediaCount = pick('totalMediaCount').asIntOrThrow();
    final String slug = pick('slug').asStringOrThrow();
    final bool nsfw = pick('nsfw').asBoolOrFalse();
    final int childCount = pick('childCount').asIntOrThrow();
    return Category(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        title: title,
        description: description,
        totalMediaCount: totalMediaCount,
        slug: slug,
        nsfw: nsfw,
        childCount: childCount);
  }
}
