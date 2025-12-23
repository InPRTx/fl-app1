// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_user_group_host_ss_node_user_group_host_dict.dart';

part 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_user_group_host.g.dart';

@JsonSerializable()
class WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost {
  const WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost({
    required this.userGroupHost,
  });

  factory WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHost.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostFromJson(
    json,
  );

  @JsonKey(name: 'user_group_host')
  final Map<
    String,
    WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict
  >
  userGroupHost;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostToJson(
        this,
      );
}
