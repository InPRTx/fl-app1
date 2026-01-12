// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'account_register_params_model.g.dart';

@JsonSerializable()
class AccountRegisterParamsModel {
  const AccountRegisterParamsModel({
    required this.email,
    required this.name,
    required this.password,
    required this.rePassword,
    this.inviteCode,
    this.emailCode,
  });

  factory AccountRegisterParamsModel.fromJson(Map<String, Object?> json) =>
      _$AccountRegisterParamsModelFromJson(json);

  /// 邮箱地址
  final String email;

  /// 用户名
  final String name;

  /// 密码
  final String password;

  /// 确认密码
  @JsonKey(name: 're_password')
  final String rePassword;

  /// 邀请码
  @JsonKey(includeIfNull: false, name: 'invite_code')
  final String? inviteCode;

  /// 邮箱验证码
  @JsonKey(includeIfNull: false, name: 'email_code')
  final String? emailCode;

  Map<String, Object?> toJson() => _$AccountRegisterParamsModelToJson(this);
}
