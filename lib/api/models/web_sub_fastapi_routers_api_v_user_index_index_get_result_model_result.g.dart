// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_index_index_get_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult
_$WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult(
  userId: (json['user_id'] as num).toInt(),
  accessType: json['access_type'] as String,
  tokenType: json['token_type'] as String,
  issuedAt: (json['issued_at'] as num).toInt(),
  expiresAt: (json['expires_at'] as num).toInt(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResultToJson(
  WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'access_type': instance.accessType,
  'token_type': instance.tokenType,
  'issued_at': instance.issuedAt,
  'expires_at': instance.expiresAt,
};
