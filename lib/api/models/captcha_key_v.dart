// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'captcha_key_v.g.dart';

@JsonSerializable()
class CaptchaKeyV {
  const CaptchaKeyV({
    required this.id,
    required this.requestIp,
    required this.capChallengeCount,
    required this.capDifficulty,
    this.createdAt,
    this.verifiedAt,
    this.consumedAt,
  });

  factory CaptchaKeyV.fromJson(Map<String, Object?> json) =>
      _$CaptchaKeyVFromJson(json);

  @JsonKey(includeIfNull: true)
  final String? id;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;

  /// 验证通过时间
  @JsonKey(includeIfNull: false, name: 'verified_at')
  final DateTime? verifiedAt;

  /// 消费时间
  @JsonKey(includeIfNull: false, name: 'consumed_at')
  final DateTime? consumedAt;
  @JsonKey(name: 'request_ip')
  final dynamic requestIp;
  @JsonKey(name: 'cap_challenge_count')
  final int capChallengeCount;
  @JsonKey(name: 'cap_difficulty')
  final int capDifficulty;

  Map<String, Object?> toJson() => _$CaptchaKeyVToJson(this);
}
