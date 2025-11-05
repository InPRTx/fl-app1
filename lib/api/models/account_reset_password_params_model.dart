// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'account_reset_password_params_model.g.dart';

@JsonSerializable()
class AccountResetPasswordParamsModel {
  const AccountResetPasswordParamsModel({
    required this.emailCode,
    required this.password,
    required this.tiago2CapToken,
    this.email,
    this.captchaKey,
  });

  factory AccountResetPasswordParamsModel.fromJson(Map<String, Object?> json) =>
      _$AccountResetPasswordParamsModelFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(name: 'email_code')
  final String emailCode;
  final String password;

  /// 一次性校验
  @JsonKey(includeIfNull: false, name: 'captcha_key')
  final String? captchaKey;

  /// Tiago2的CAPTCHA令牌
  @JsonKey(name: 'tiago2_cap_token')
  final String tiago2CapToken;

  Map<String, Object?> toJson() =>
      _$AccountResetPasswordParamsModelToJson(this);
}
