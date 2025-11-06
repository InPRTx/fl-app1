// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_code_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEmailCodeParamsModel _$RequestEmailCodeParamsModelFromJson(
  Map<String, dynamic> json,
) => RequestEmailCodeParamsModel(
  tiago2CapToken: json['tiago2_cap_token'] as String,
  email: json['email'] as String?,
  captchaKey: json['captcha_key'] as String?,
);

Map<String, dynamic> _$RequestEmailCodeParamsModelToJson(
  RequestEmailCodeParamsModel instance,
) => <String, dynamic>{
  'email': ?instance.email,
  'captcha_key': ?instance.captchaKey,
  'tiago2_cap_token': instance.tiago2CapToken,
};
