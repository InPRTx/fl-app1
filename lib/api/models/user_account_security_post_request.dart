// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_security_post_request.g.dart';

@JsonSerializable()
class UserAccountSecurityPostRequest {
  const UserAccountSecurityPostRequest({
    this.gaEnable,
    this.emailNotification,
    this.gaToken,
  });

  factory UserAccountSecurityPostRequest.fromJson(Map<String, Object?> json) =>
      _$UserAccountSecurityPostRequestFromJson(json);

  /// 是否启用双因素认证
  @JsonKey(includeIfNull: false, name: 'ga_enable')
  final bool? gaEnable;

  /// 是否启用邮件通知
  @JsonKey(includeIfNull: false, name: 'email_notification')
  final bool? emailNotification;

  /// Google Authenticator密钥
  @JsonKey(includeIfNull: false, name: 'ga_token')
  final String? gaToken;

  Map<String, Object?> toJson() => _$UserAccountSecurityPostRequestToJson(this);
}
