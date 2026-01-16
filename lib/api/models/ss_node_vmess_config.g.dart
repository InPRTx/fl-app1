// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_vmess_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeVmessConfig _$SsNodeVmessConfigFromJson(Map<String, dynamic> json) =>
    SsNodeVmessConfig(
      host: json['host'] as String? ?? '',
      verifyCert: json['verify_cert'] as bool? ?? true,
      port: (json['port'] as num?)?.toInt() ?? 443,
      alterId: (json['alter_id'] as num?)?.toInt() ?? 0,
      netType: json['net_type'] as String? ?? 'tcp',
    );

Map<String, dynamic> _$SsNodeVmessConfigToJson(SsNodeVmessConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'verify_cert': instance.verifyCert,
      'port': instance.port,
      'alter_id': instance.alterId,
      'net_type': instance.netType,
    };
