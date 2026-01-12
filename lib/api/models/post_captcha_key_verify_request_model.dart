// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'post_captcha_key_verify_request_model.g.dart';

/// 验证码验证请求模型
@JsonSerializable()
class PostCaptchaKeyVerifyRequestModel {
  const PostCaptchaKeyVerifyRequestModel({
    required this.capId,
    required this.solutions,
  });

  factory PostCaptchaKeyVerifyRequestModel.fromJson(
    Map<String, Object?> json,
  ) => _$PostCaptchaKeyVerifyRequestModelFromJson(json);

  /// 验证码ID（UUID7格式）
  @JsonKey(name: 'cap_id')
  final String capId;

  /// SHA256 POW验证码的解决方案数组
  final List<int> solutions;

  Map<String, Object?> toJson() =>
      _$PostCaptchaKeyVerifyRequestModelToJson(this);
}
