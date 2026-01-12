// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_user_group_host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHost
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHost(
  userGroupHost: (json['user_group_host'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict.fromJson(
        e as Map<String, dynamic>,
      ),
    ),
  ),
);

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHost
  instance,
) => <String, dynamic>{'user_group_host': instance.userGroupHost};
