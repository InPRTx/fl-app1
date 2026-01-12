// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel {
  const WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel({
    required this.email,
    required this.password,
    this.isRememberMe = false,
    this.twoFaCode,
    this.verifyToken,
  });

  factory WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModelFromJson(json);

  final String email;
  final String password;

  /// 二次验证代码，如果没有则不传
  @JsonKey(includeIfNull: false, name: 'two_fa_code')
  final String? twoFaCode;

  /// 如果是True，則refresh_token的有效期限為30天，否則為1小時
  @JsonKey(name: 'is_remember_me')
  final bool isRememberMe;

  /// POW验证令牌
  @JsonKey(includeIfNull: false, name: 'verify_token')
  final String? verifyToken;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModelToJson(this);
}
