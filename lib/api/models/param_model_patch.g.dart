// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'param_model_patch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParamModelPatch _$ParamModelPatchFromJson(Map<String, dynamic> json) =>
    ParamModelPatch(
      email: json['email'] as String?,
      userName: json['user_name'] as String?,
      isEnable: json['is_enable'] as bool?,
      telegramId: (json['telegram_id'] as num?)?.toInt(),
      isEmailVerify: json['is_email_verify'] as bool?,
      userAccountExpireIn: json['user_account_expire_in'] == null
          ? null
          : DateTime.parse(json['user_account_expire_in'] as String),
    );

Map<String, dynamic> _$ParamModelPatchToJson(
  ParamModelPatch instance,
) => <String, dynamic>{
  'email': ?instance.email,
  'user_name': ?instance.userName,
  'is_enable': ?instance.isEnable,
  'telegram_id': ?instance.telegramId,
  'is_email_verify': ?instance.isEmailVerify,
  'user_account_expire_in': ?instance.userAccountExpireIn?.toIso8601String(),
};
