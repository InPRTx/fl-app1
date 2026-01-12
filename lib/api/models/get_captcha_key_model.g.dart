// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_captcha_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCaptchaKeyModel _$GetCaptchaKeyModelFromJson(Map<String, dynamic> json) =>
    GetCaptchaKeyModel(
      message: json['message'] as String,
      result: CaptchaKeyV.fromJson(json['result'] as Map<String, dynamic>),
      isSuccess: json['is_success'] as bool? ?? false,
    );

Map<String, dynamic> _$GetCaptchaKeyModelToJson(GetCaptchaKeyModel instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'result': instance.result,
    };
