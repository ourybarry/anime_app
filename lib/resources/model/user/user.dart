import 'package:anime/resources/model/anime/poster_image.dart';
import 'package:deep_pick/deep_pick.dart';

class User {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final List<String> pastNames;
  final String? slug;
  final String about;
  final String? location;
  // final String waifuOrHusbando;
  final int followersCount;
  final int followingCount;
  // final String birthday;
  // final String gender;
  // final int commentsCount;
  // final int favoritesCount;
  // final int likesGivenCount;
  final int reviewsCount;
  // final int likesReceivedCount;
  final int postsCount;
  // final int ratingsCounts;
  // final int mediaReactionsCount;
  // final String proExpiresAt;
  final String? title;
  final bool profileCompleted;
  final bool feedCompleted;
  final String? website;
  final String? proTier;
  final PosterImage? avatar;
  final PosterImage? coverImage;
  final String email;
// final String password;
  // final bool emailConfirmed;
  // final String previousEmail;
  // final String language;
  // final String timezone;
  // final String country;
  // final bool shareToGlobal;
  // final TitleLanguagePreference titleLanguagePreference;
  // final bool sfwFilter;
  // final String ratingSystem; //Should be enum
  // final String theme; //Should be enum
  // final String facebookId;
  // final bool hasPassword;
  // final String status;
  // final bool subscribedToNewsletter;
  // final String aoPro;
  User(
      this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.pastNames,
      this.slug,
      this.about,
      this.location,
      this.followersCount,
      this.followingCount,
      this.reviewsCount,
      this.postsCount,
      this.title,
      this.profileCompleted,
      this.feedCompleted,
      this.website,
      this.proTier,
      this.avatar,
      this.coverImage,
      this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    final int id = pick(json, 'id').asIntOrThrow();
    final DateTime createdAt = pick(json, 'createdAt').asDateTimeOrThrow();
    final DateTime updatedAt = pick(json, 'updatedAt').asDateTimeOrThrow();
    final String name = pick(json, 'name').asStringOrThrow();
    final List<String> pastNames =
        pick(json, 'pastNames').asListOrEmpty((p0) => p0.asString());
    final String? slug = pick(json, 'slug').asStringOrNull();
    final String about = pick(json, 'about').asStringOrThrow();
    final String? location = pick(json, 'location').asStringOrNull();
    final int followers = pick(json, 'followersCount').asIntOrThrow();
    final int following = pick(json, 'followingCount').asIntOrThrow();
    final int reviewsCount = pick(json, 'reviewsCount').asIntOrThrow();
    final int postsCount = pick(json, 'postsCount').asIntOrThrow();
    final String? title = pick(json, 'title').asStringOrNull();
    final bool profileCompleted =
        pick(json, 'profileCompleted').asBoolOrFalse();
    final bool feedCompleted = pick(json, 'feedCompleted').asBoolOrFalse();
    final String? website = pick(json, 'website').asStringOrNull();
    final String? proTier = pick(json, 'proTier').asStringOrNull();
    final PosterImage? avatarImage =
        pick(json, 'avatar').letOrNull((pick) => PosterImage.fromPick(pick));
    final PosterImage? coverImage = pick(json, 'coverImage')
        .letOrNull((pick) => PosterImage.fromPick(pick));
    final String email = pick(json, 'email').asStringOrThrow();
    return User(
        id,
        createdAt,
        updatedAt,
        name,
        pastNames,
        slug,
        about,
        location,
        followers,
        following,
        reviewsCount,
        postsCount,
        title,
        profileCompleted,
        feedCompleted,
        website,
        proTier,
        avatarImage,
        coverImage,
        email);
  }
}

enum TitleLanguagePreference { CANONICAL, ROMANIZED, ENGLISH }
