import 'dart:convert';

import 'package:deep_pick/deep_pick.dart';

class UserToken {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String scope;
  final int createdAt;

  const UserToken(this.accessToken, this.tokenType, this.expiresIn,
      this.refreshToken, this.scope, this.createdAt);

  factory UserToken.fromJson(Map<String, dynamic> json) {
    final String accessToken = pick(json, 'access_token').asStringOrThrow();
    final String tokenType = pick(json, 'token_type').asStringOrThrow();
    final int expiresIn = pick(json, 'expires_in').asIntOrThrow();
    final String refreshToken = pick(json, 'refresh_token').asStringOrThrow();
    final String scope = pick(json, 'scope').asStringOrThrow();
    final int createdAt = pick(json, 'created_at').asIntOrThrow();

    return UserToken(
        accessToken, tokenType, expiresIn, refreshToken, scope, createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'scope': scope,
      'created_at': createdAt,
    };
  }

  String serialize() => json.encode(toMap());
  factory UserToken.deserialize(String data) {
    final decoded = json.decode(data);
    return UserToken.fromJson(decoded);
  }
}
