// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  userId: (json['user_id'] as num).toInt(),
  accessType: json['access_type'] as String,
  tokenType: json['token_type'] as String,
  issuedAt: (json['issued_at'] as num).toInt(),
  expiresAt: (json['expires_at'] as num).toInt(),
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'user_id': instance.userId,
  'access_type': instance.accessType,
  'token_type': instance.tokenType,
  'issued_at': instance.issuedAt,
  'expires_at': instance.expiresAt,
};
