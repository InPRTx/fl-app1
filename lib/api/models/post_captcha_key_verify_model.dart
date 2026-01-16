// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_captcha_key_v_post_captcha_key_verify_model_result.dart';

part 'post_captcha_key_verify_model.g.dart';

@JsonSerializable()
class PostCaptchaKeyVerifyModel {
  const PostCaptchaKeyVerifyModel({
    required this.message,
    this.result,
    this.isSuccess = false,
  });

  factory PostCaptchaKeyVerifyModel.fromJson(Map<String, Object?> json) =>
      _$PostCaptchaKeyVerifyModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 消息提示
  final String message;
  @JsonKey(includeIfNull: false)
  final WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult?
  result;

  Map<String, Object?> toJson() => _$PostCaptchaKeyVerifyModelToJson(this);
}
