import 'package:deep_pick/deep_pick.dart';

class PosterImage {
  final String? tiny;
  final String? small;
  final String? medium;
  final String? large;
  final String original;

  const PosterImage(
      {this.tiny, this.small, this.medium, this.large, required this.original});
  factory PosterImage.fromPick(RequiredPick pick) {
    final String? tiny = pick('tiny').asStringOrNull();
    final String? small = pick('small').asStringOrNull();
    final String? medium = pick('medium').asStringOrNull();
    final String? large = pick('large').asStringOrNull();
    final String original = pick('original').asStringOrThrow();

    return PosterImage(
        tiny: tiny,
        small: small,
        medium: medium,
        large: large,
        original: original);
  }
}
