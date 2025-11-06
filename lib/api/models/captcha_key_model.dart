// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'captcha_key_type_enum.dart';

part 'captcha_key_model.g.dart';

@JsonSerializable()
class CaptchaKeyModel {
  const CaptchaKeyModel({
    required this.message,
    required this.captchaKeyType,
    required this.tiago2CapKeyId,
    this.captchaKey,
    this.isSuccess = false,
  });

  factory CaptchaKeyModel.fromJson(Map<String, Object?> json) =>
      _$CaptchaKeyModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 消息提示
  final String message;

  /// 一次性校验
  @JsonKey(includeIfNull: false, name: 'captcha_key')
  final String? captchaKey;
  @JsonKey(name: 'captcha_key_type')
  final CaptchaKeyTypeEnum captchaKeyType;

  /// 验证码功能
  @JsonKey(name: 'tiago2_cap_key_id')
  final String tiago2CapKeyId;

  Map<String, Object?> toJson() => _$CaptchaKeyModelToJson(this);
}
