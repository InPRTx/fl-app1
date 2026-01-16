// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_captcha_key_verify_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCaptchaKeyVerifyRequestModel _$PostCaptchaKeyVerifyRequestModelFromJson(
  Map<String, dynamic> json,
) => PostCaptchaKeyVerifyRequestModel(
  capId: json['cap_id'] as String,
  solutions: (json['solutions'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$PostCaptchaKeyVerifyRequestModelToJson(
  PostCaptchaKeyVerifyRequestModel instance,
) => <String, dynamic>{
  'cap_id': instance.capId,
  'solutions': instance.solutions,
};
