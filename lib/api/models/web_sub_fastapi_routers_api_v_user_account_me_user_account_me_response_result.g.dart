// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_account_me_user_account_me_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult
_$WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult(
  userId: (json['user_id'] as num).toInt(),
  userNewId: json['user_new_id'] as String,
  email: json['email'] as String,
  userName: json['user_name'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  isVerified: json['is_verified'] as bool? ?? true,
  telegramLinked: json['telegram_linked'] as bool? ?? false,
  lastLogin: json['last_login'] == null
      ? null
      : DateTime.parse(json['last_login'] as String),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResultToJson(
  WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_new_id': instance.userNewId,
  'email': instance.email,
  'user_name': instance.userName,
  'created_at': instance.createdAt.toIso8601String(),
  'last_login': ?instance.lastLogin?.toIso8601String(),
  'is_verified': instance.isVerified,
  'telegram_linked': instance.telegramLinked,
};
