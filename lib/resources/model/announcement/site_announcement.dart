import 'package:deep_pick/deep_pick.dart';

class SiteAnnouncement {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String title;
  final String description;
  final String? image;
  final String url;

  const SiteAnnouncement(
      {required this.createdAt,
      this.updatedAt,
      required this.title,
      required this.description,
      this.image,
      required this.url});

  factory SiteAnnouncement.fromPick(RequiredPick pick) {
    final DateTime createdAt = pick('createdAt').asDateTimeOrThrow();
    final DateTime? updatedAt = pick('updatedAt').asDateTimeOrNull();
    final String title = pick('title').asStringOrThrow();
    final String description = pick('description').asStringOrThrow();
    final String? image = pick('imageUrl').asStringOrNull();
    final String url = pick('link').asStringOrThrow();
    return SiteAnnouncement(
        createdAt: createdAt,
        updatedAt: updatedAt,
        title: title,
        description: description,
        image: image,
        url: url);
  }
}
