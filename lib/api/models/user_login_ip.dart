// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_login_ip.g.dart';

@JsonSerializable()
class UserLoginIp {
  const UserLoginIp({
    required this.userId,
    required this.loginIp,
    this.isLogin = true,
    this.id,
    this.createdAt,
  });

  factory UserLoginIp.fromJson(Map<String, Object?> json) =>
      _$UserLoginIpFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'login_ip')
  final String loginIp;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'is_login')
  final bool isLogin;

  Map<String, Object?> toJson() => _$UserLoginIpToJson(this);
}
