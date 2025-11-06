// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmess_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VmessConfig _$VmessConfigFromJson(Map<String, dynamic> json) => VmessConfig(
  host: json['host'] as String? ?? '',
  verifyCert: json['verify_cert'] as bool? ?? true,
  port: (json['port'] as num?)?.toInt() ?? 443,
  alterId: (json['alter_id'] as num?)?.toInt() ?? 0,
  netType: json['net_type'] as String? ?? 'tcp',
);

Map<String, dynamic> _$VmessConfigToJson(VmessConfig instance) =>
    <String, dynamic>{
      'host': instance.host,
      'verify_cert': instance.verifyCert,
      'port': instance.port,
      'alter_id': instance.alterId,
      'net_type': instance.netType,
    };
