// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel
_$WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModelFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
  email: json['email'] as String,
  password: json['password'] as String,
  captchaKey: json['captcha_key'] as String,
  tiago2CapToken: json['tiago2_cap_token'] as String,
  isRememberMe: json['is_remember_me'] as bool? ?? false,
  twoFaCode: json['two_fa_code'] as String?,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModelToJson(
  WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'two_fa_code': ?instance.twoFaCode,
  'is_remember_me': instance.isRememberMe,
  'captcha_key': instance.captchaKey,
  'tiago2_cap_token': instance.tiago2CapToken,
};
