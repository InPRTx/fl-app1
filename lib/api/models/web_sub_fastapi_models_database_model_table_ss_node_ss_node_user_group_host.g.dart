// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_user_group_host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost
_$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost(
  userGroupHost: (json['user_group_host'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict.fromJson(
        e as Map<String, dynamic>,
      ),
    ),
  ),
);

Map<String, dynamic>
_$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostToJson(
  WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost instance,
) => <String, dynamic>{'user_group_host': instance.userGroupHost};
