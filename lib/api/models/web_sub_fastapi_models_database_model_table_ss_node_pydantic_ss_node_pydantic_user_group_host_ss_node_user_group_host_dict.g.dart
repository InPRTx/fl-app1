// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_user_group_host_ss_node_user_group_host_dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDictFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict(
      host: json['host'] as String,
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDictToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict
  instance,
) => <String, dynamic>{'host': instance.host, 'port': ?instance.port};
