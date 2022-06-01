import 'package:anime/resources/model/character/character.dart';
import 'package:deep_pick/deep_pick.dart';

class CharacterResult {
  final List<Character> data;

  CharacterResult({required this.data});

  factory CharacterResult.fromJson(Map<String, dynamic> json) {
    final List<Character> data =
        pick(json, 'data').asListOrEmpty((p0) => Character.fromPick(p0));
    return CharacterResult(data: data);
  }
}
