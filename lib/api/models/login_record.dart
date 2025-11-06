// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'login_record.g.dart';

@JsonSerializable()
class LoginRecord {
  const LoginRecord({
    required this.loginTime,
    required this.ipAddress,
    required this.userAgent,
  });

  factory LoginRecord.fromJson(Map<String, Object?> json) =>
      _$LoginRecordFromJson(json);

  /// 登录时间戳
  @JsonKey(name: 'login_time')
  final int loginTime;

  /// 登录IP地址
  @JsonKey(name: 'ip_address')
  final String ipAddress;

  /// 用户代理
  @JsonKey(name: 'user_agent')
  final String userAgent;

  Map<String, Object?> toJson() => _$LoginRecordToJson(this);
}
