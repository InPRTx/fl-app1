// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_user_group_host_ss_node_user_group_host_dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict
_$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDictFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict(
      host: json['host'] as String,
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDictToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict
  instance,
) => <String, dynamic>{'host': instance.host, 'port': ?instance.port};
