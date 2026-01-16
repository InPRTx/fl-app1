// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_captcha_key_v_post_captcha_key_verify_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult {
  const WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult({
    required this.verifyToken,
    required this.expiresAt,
  });

  factory WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResultFromJson(
        json,
      );

  /// 验证成功后的令牌，用于后续业务消费
  @JsonKey(name: 'verify_token')
  final String verifyToken;

  /// 令牌过期时间
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVCaptchaKeyVPostCaptchaKeyVerifyModelResultToJson(
        this,
      );
}
