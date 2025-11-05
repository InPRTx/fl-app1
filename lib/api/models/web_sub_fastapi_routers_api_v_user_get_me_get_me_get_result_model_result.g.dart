// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_get_me_get_me_get_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult
_$WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult(
  userId: (json['user_id'] as num).toInt(),
  userNewId: json['user_new_id'] as String,
  email: json['email'] as String,
  userName: json['user_name'] as String,
  userAccountExpireIn: DateTime.parse(json['user_account_expire_in'] as String),
  tgId: (json['tg_id'] as num?)?.toInt(),
  isBan: json['is_ban'] as bool? ?? false,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResultToJson(
  WebSubFastapiRoutersApiVUserGetMeGetMeGetResultModelResult instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_new_id': instance.userNewId,
  'email': instance.email,
  'is_ban': instance.isBan,
  'tg_id': ?instance.tgId,
  'user_name': instance.userName,
  'user_account_expire_in': instance.userAccountExpireIn.toIso8601String(),
};
