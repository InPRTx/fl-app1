// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_node_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeNodeConfig _$SsNodeNodeConfigFromJson(Map<String, dynamic> json) =>
    SsNodeNodeConfig(
      host: json['host'] as String?,
      port: (json['port'] as num?)?.toInt(),
      vmessConfig: json['vmess_config'] == null
          ? null
          : SsNodeVmessConfig.fromJson(
              json['vmess_config'] as Map<String, dynamic>,
            ),
      ssrConfig: json['ssr_config'] == null
          ? null
          : SsNodeSsrConfig.fromJson(
              json['ssr_config'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SsNodeNodeConfigToJson(SsNodeNodeConfig instance) =>
    <String, dynamic>{
      'host': ?instance.host,
      'port': ?instance.port,
      'vmess_config': ?instance.vmessConfig,
      'ssr_config': ?instance.ssrConfig,
    };
