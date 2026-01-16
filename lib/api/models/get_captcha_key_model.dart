// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'captcha_key_v.dart';

part 'get_captcha_key_model.g.dart';

@JsonSerializable()
class GetCaptchaKeyModel {
  const GetCaptchaKeyModel({
    required this.message,
    required this.result,
    this.isSuccess = false,
  });

  factory GetCaptchaKeyModel.fromJson(Map<String, Object?> json) =>
      _$GetCaptchaKeyModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 消息提示
  final String message;
  final CaptchaKeyV result;

  Map<String, Object?> toJson() => _$GetCaptchaKeyModelToJson(this);
}
