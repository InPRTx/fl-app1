// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_key_v.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaKeyV _$CaptchaKeyVFromJson(Map<String, dynamic> json) => CaptchaKeyV(
  id: json['id'] as String?,
  requestIp: json['request_ip'],
  capChallengeCount: (json['cap_challenge_count'] as num).toInt(),
  capDifficulty: (json['cap_difficulty'] as num).toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  verifiedAt: json['verified_at'] == null
      ? null
      : DateTime.parse(json['verified_at'] as String),
  consumedAt: json['consumed_at'] == null
      ? null
      : DateTime.parse(json['consumed_at'] as String),
);

Map<String, dynamic> _$CaptchaKeyVToJson(CaptchaKeyV instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'verified_at': ?instance.verifiedAt?.toIso8601String(),
      'consumed_at': ?instance.consumedAt?.toIso8601String(),
      'request_ip': instance.requestIp,
      'cap_challenge_count': instance.capChallengeCount,
      'cap_difficulty': instance.capDifficulty,
    };
