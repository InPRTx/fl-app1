// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_node_config_vmess_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigVmessConfig
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigVmessConfigFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigVmessConfig(
      host: json['host'] as String? ?? '',
      verifyCert: json['verify_cert'] as bool? ?? true,
      port: (json['port'] as num?)?.toInt() ?? 443,
      alterId: (json['alter_id'] as num?)?.toInt() ?? 0,
      netType: json['net_type'] as String? ?? 'tcp',
    );

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigVmessConfigToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticNodeConfigVmessConfig
  instance,
) => <String, dynamic>{
  'host': instance.host,
  'verify_cert': instance.verifyCert,
  'port': instance.port,
  'alter_id': instance.alterId,
  'net_type': instance.netType,
};
