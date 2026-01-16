// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_captcha_key_v_post_captcha_key_verify_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult
_$WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult(
  verifyToken: json['verify_token'] as String,
  expiresAt: DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResultToJson(
  WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult instance,
) => <String, dynamic>{
  'verify_token': instance.verifyToken,
  'expires_at': instance.expiresAt.toIso8601String(),
};
