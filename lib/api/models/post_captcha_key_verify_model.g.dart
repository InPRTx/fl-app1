// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_captcha_key_verify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCaptchaKeyVerifyModel _$PostCaptchaKeyVerifyModelFromJson(
  Map<String, dynamic> json,
) => PostCaptchaKeyVerifyModel(
  message: json['message'] as String,
  result: json['result'] == null
      ? null
      : WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult.fromJson(
          json['result'] as Map<String, dynamic>,
        ),
  isSuccess: json['is_success'] as bool? ?? false,
);

Map<String, dynamic> _$PostCaptchaKeyVerifyModelToJson(
  PostCaptchaKeyVerifyModel instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
