// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_v_param_model_put.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut
_$WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPutFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut(
  email: json['email'] as String,
  userName: json['user_name'] as String,
  isEnable: json['is_enable'] as bool,
  isEmailVerify: json['is_email_verify'] as bool,
  userAccountExpireIn: DateTime.parse(json['user_account_expire_in'] as String),
  telegramId: (json['telegram_id'] as num?)?.toInt(),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPutToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut instance,
) => <String, dynamic>{
  'email': instance.email,
  'user_name': instance.userName,
  'is_enable': instance.isEnable,
  'telegram_id': ?instance.telegramId,
  'is_email_verify': instance.isEmailVerify,
  'user_account_expire_in': instance.userAccountExpireIn.toIso8601String(),
};
