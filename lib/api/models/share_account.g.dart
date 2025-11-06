// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareAccount _$ShareAccountFromJson(Map<String, dynamic> json) => ShareAccount(
  accountId: (json['account_id'] as num).toInt(),
  accountName: json['account_name'] as String,
  serverAddress: json['server_address'] as String,
  port: (json['port'] as num).toInt(),
  password: json['password'] as String,
  method: json['method'] as String,
  protocol: json['protocol'] as String,
  maxUsers: (json['max_users'] as num).toInt(),
  currentUsers: (json['current_users'] as num).toInt(),
  trafficLimit: (json['traffic_limit'] as num).toInt(),
  trafficUsed: (json['traffic_used'] as num).toInt(),
  status: json['status'] as String,
  expireTime: DateTime.parse(json['expire_time'] as String),
);

Map<String, dynamic> _$ShareAccountToJson(ShareAccount instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'account_name': instance.accountName,
      'server_address': instance.serverAddress,
      'port': instance.port,
      'password': instance.password,
      'method': instance.method,
      'protocol': instance.protocol,
      'max_users': instance.maxUsers,
      'current_users': instance.currentUsers,
      'traffic_limit': instance.trafficLimit,
      'traffic_used': instance.trafficUsed,
      'status': instance.status,
      'expire_time': instance.expireTime.toIso8601String(),
    };
