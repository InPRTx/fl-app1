// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'share_account.g.dart';

@JsonSerializable()
class ShareAccount {
  const ShareAccount({
    required this.accountId,
    required this.accountName,
    required this.serverAddress,
    required this.port,
    required this.password,
    required this.method,
    required this.protocol,
    required this.maxUsers,
    required this.currentUsers,
    required this.trafficLimit,
    required this.trafficUsed,
    required this.status,
    required this.expireTime,
  });

  factory ShareAccount.fromJson(Map<String, Object?> json) =>
      _$ShareAccountFromJson(json);

  /// 共享账户ID
  @JsonKey(name: 'account_id')
  final int accountId;

  /// 账户名称
  @JsonKey(name: 'account_name')
  final String accountName;

  /// 服务器地址
  @JsonKey(name: 'server_address')
  final String serverAddress;

  /// 端口号
  final int port;

  /// 密码
  final String password;

  /// 加密方式
  final String method;

  /// 协议类型
  final String protocol;

  /// 最大用户数
  @JsonKey(name: 'max_users')
  final int maxUsers;

  /// 当前用户数
  @JsonKey(name: 'current_users')
  final int currentUsers;

  /// 流量限制(字节)
  @JsonKey(name: 'traffic_limit')
  final int trafficLimit;

  /// 已用流量(字节)
  @JsonKey(name: 'traffic_used')
  final int trafficUsed;

  /// 账户状态
  final String status;

  /// 到期时间
  @JsonKey(name: 'expire_time')
  final DateTime expireTime;

  Map<String, Object?> toJson() => _$ShareAccountToJson(this);
}
