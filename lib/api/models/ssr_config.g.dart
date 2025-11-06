// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssr_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsrConfig _$SsrConfigFromJson(Map<String, dynamic> json) => SsrConfig(
  host: json['host'] as String? ?? '',
  port: (json['port'] as num?)?.toInt() ?? 443,
  password: json['password'] as String? ?? '',
  method: json['method'] as String? ?? 'aes-256-cfb',
  protocol: json['protocol'] as String? ?? 'origin',
  protocolParam: json['protocol_param'] as String? ?? '',
  obfs: json['obfs'] as String? ?? 'plain',
  obfsParam: json['obfs_param'] as String? ?? '',
);

Map<String, dynamic> _$SsrConfigToJson(SsrConfig instance) => <String, dynamic>{
  'host': instance.host,
  'port': instance.port,
  'password': instance.password,
  'method': instance.method,
  'protocol': instance.protocol,
  'protocol_param': instance.protocolParam,
  'obfs': instance.obfs,
  'obfs_param': instance.obfsParam,
};
