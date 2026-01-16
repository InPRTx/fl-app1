// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_node_config_sql_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeNodeConfigSqlModel _$SsNodeNodeConfigSqlModelFromJson(
  Map<String, dynamic> json,
) => SsNodeNodeConfigSqlModel(
  host: json['host'] as String?,
  port: (json['port'] as num?)?.toInt(),
  vmessConfig: json['vmess_config'] == null
      ? null
      : SsNodeVmessConfigSqlModel.fromJson(
          json['vmess_config'] as Map<String, dynamic>,
        ),
  ssrConfig: json['ssr_config'] == null
      ? null
      : SsNodeSsrConfigSqlModel.fromJson(
          json['ssr_config'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SsNodeNodeConfigSqlModelToJson(
  SsNodeNodeConfigSqlModel instance,
) => <String, dynamic>{
  'host': ?instance.host,
  'port': ?instance.port,
  'vmess_config': ?instance.vmessConfig,
  'ssr_config': ?instance.ssrConfig,
};
