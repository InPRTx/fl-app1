// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_reset_password_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountResetPasswordParamsModel _$AccountResetPasswordParamsModelFromJson(
  Map<String, dynamic> json,
) => AccountResetPasswordParamsModel(
  emailCode: json['email_code'] as String,
  password: json['password'] as String,
  tiago2CapToken: json['tiago2_cap_token'] as String,
  email: json['email'] as String?,
  captchaKey: json['captcha_key'] as String?,
);

Map<String, dynamic> _$AccountResetPasswordParamsModelToJson(
  AccountResetPasswordParamsModel instance,
) => <String, dynamic>{
  'email': ?instance.email,
  'email_code': instance.emailCode,
  'password': instance.password,
  'captcha_key': ?instance.captchaKey,
  'tiago2_cap_token': instance.tiago2CapToken,
};
