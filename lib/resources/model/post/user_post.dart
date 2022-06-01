import 'package:deep_pick/deep_pick.dart';

class UserPost {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;
  final String contentFormatted;
  final int commentsCount;
  final int postLikesCount;
  final bool hasSpoiler;
  final bool nsfw;
  final bool blocked;
  final String deletedAt;
  final int topLevelCommentsCount;
  final String editedAt;
  final String targetInterest;
  final String embed;
  final String embedUrl;

  const UserPost(
      this.createdAt,
      this.updatedAt,
      this.content,
      this.contentFormatted,
      this.commentsCount,
      this.postLikesCount,
      this.hasSpoiler,
      this.nsfw,
      this.blocked,
      this.deletedAt,
      this.topLevelCommentsCount,
      this.editedAt,
      this.targetInterest,
      this.embed,
      this.embedUrl);

  factory UserPost.fromPick(RequiredPick pick) {
    final DateTime createdAt = pick('createdAt').asDateTimeOrThrow();
    final DateTime updatedAt = pick('updatedAt').asDateTimeOrThrow();
    final String content = pick('content').asStringOrThrow();
    final String contentFormatted = pick('contentFormatted').asStringOrThrow();
    final int commentsCount = pick('commentsCount').asIntOrThrow();
    final int postLikesCount = pick('postLikesCount').asIntOrThrow();
    final bool hasSpoiler = pick('spoiler').asBoolOrFalse();
    final bool nsfw = pick('nsfw').asBoolOrFalse();
    final bool blocked = pick('blocked').asBoolOrFalse();
    final String deletedAt = pick('deletedAt').asStringOrThrow();
    final int topLevelCommentsCount =
        pick('topLevelCommentsCount').asIntOrThrow();
    final String editedAt = pick('editedAt').asStringOrThrow();
    final String targetInterest = pick('targetInterest').asStringOrThrow();
    final String embed = pick('embed').asStringOrThrow();
    final String embedUrl = pick('embedUrl').asStringOrThrow();

    return UserPost(
        createdAt,
        updatedAt,
        content,
        contentFormatted,
        commentsCount,
        postLikesCount,
        hasSpoiler,
        nsfw,
        blocked,
        deletedAt,
        topLevelCommentsCount,
        editedAt,
        targetInterest,
        embed,
        embedUrl);
  }
}
