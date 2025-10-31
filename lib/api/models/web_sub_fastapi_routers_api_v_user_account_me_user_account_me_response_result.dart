// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_account_me_user_account_me_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult {
  const WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult({
    required this.userId,
    required this.userNewId,
    required this.email,
    required this.userName,
    required this.createdAt,
    this.isVerified = true,
    this.telegramLinked = false,
    this.lastLogin,
  });

  factory WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResult.fromJson(
      Map<String, Object?> json) =>
      _$WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResultFromJson(
          json);
  
  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 用户新型ID
  @JsonKey(name: 'user_new_id')
  final String userNewId;

  /// 用户邮箱
  final String email;

  /// 用户昵称
  @JsonKey(name: 'user_name')
  final String userName;

  /// 账户创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 最后登录时间
  @JsonKey(name: 'last_login')
  final DateTime? lastLogin;

  /// 是否已验证邮箱
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  /// 是否已绑定Telegram
  @JsonKey(name: 'telegram_linked')
  final bool telegramLinked;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserAccountMeUserAccountMeResponseResultToJson(
          this);
}
