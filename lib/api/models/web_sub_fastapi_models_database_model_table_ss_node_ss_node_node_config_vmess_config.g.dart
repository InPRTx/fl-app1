// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_node_config_vmess_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigVmessConfig
_$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigVmessConfigFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigVmessConfig(
  host: json['host'] as String? ?? '',
  verifyCert: json['verify_cert'] as bool? ?? true,
  port: (json['port'] as num?)?.toInt() ?? 443,
  alterId: (json['alter_id'] as num?)?.toInt() ?? 0,
  netType: json['net_type'] as String? ?? 'tcp',
);

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigVmessConfigToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeNodeConfigVmessConfig
  instance,
) => <String, dynamic>{
  'host': instance.host,
  'verify_cert': instance.verifyCert,
  'port': instance.port,
  'alter_id': instance.alterId,
  'net_type': instance.netType,
};
