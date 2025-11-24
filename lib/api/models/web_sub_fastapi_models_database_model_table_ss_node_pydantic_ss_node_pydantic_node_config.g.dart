// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_node_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig(
  host: json['host'] as String?,
  port: (json['port'] as num?)?.toInt(),
  vmessConfig: json['vmess_config'] == null
      ? null
      : WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigVmessConfig.fromJson(
          json['vmess_config'] as Map<String, dynamic>,
        ),
  ssrConfig: json['ssr_config'] == null
      ? null
      : WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigSsrConfig.fromJson(
          json['ssr_config'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfig
  instance,
) => <String, dynamic>{
  'host': ?instance.host,
  'port': ?instance.port,
  'vmess_config': ?instance.vmessConfig,
  'ssr_config': ?instance.ssrConfig,
};
