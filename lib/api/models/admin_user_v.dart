// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'admin_user_v.g.dart';

@JsonSerializable()
class AdminUserV {
  const AdminUserV({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.userName,
    required this.isEnabled,
    required this.tgId,
    required this.regIp,
    required this.userAccountExpireIn,
    this.isEmailVerify = false,
  });

  factory AdminUserV.fromJson(Map<String, Object?> json) =>
      _$AdminUserVFromJson(json);

  /// 用户ID,只读
  final int id;

  /// 注册时间,只读
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String email;
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;
  @JsonKey(includeIfNull: true, name: 'tg_id')
  final int? tgId;
  @JsonKey(name: 'reg_ip')
  final dynamic regIp;
  @JsonKey(name: 'is_email_verify')
  final bool isEmailVerify;

  /// 用户账户过期时间 expire_in
  @JsonKey(name: 'user_account_expire_in')
  final DateTime userAccountExpireIn;

  Map<String, Object?> toJson() => _$AdminUserVToJson(this);
}
