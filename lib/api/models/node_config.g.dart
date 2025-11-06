// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeConfig _$NodeConfigFromJson(Map<String, dynamic> json) => NodeConfig(
  host: json['host'] as String?,
  port: (json['port'] as num?)?.toInt(),
  vmessConfig: json['vmess_config'] == null
      ? null
      : VmessConfig.fromJson(json['vmess_config'] as Map<String, dynamic>),
  ssrConfig: json['ssr_config'] == null
      ? null
      : SsrConfig.fromJson(json['ssr_config'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NodeConfigToJson(NodeConfig instance) =>
    <String, dynamic>{
      'host': ?instance.host,
      'port': ?instance.port,
      'vmess_config': ?instance.vmessConfig,
      'ssr_config': ?instance.ssrConfig,
    };
