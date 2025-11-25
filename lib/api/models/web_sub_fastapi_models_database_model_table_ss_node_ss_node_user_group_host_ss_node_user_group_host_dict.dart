// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_models_database_model_table_ss_node_ss_node_user_group_host_ss_node_user_group_host_dict.g.dart';

@JsonSerializable()
class WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict {
  const WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict({
    required this.host,
    this.port,
  });

  factory WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDictFromJson(
        json,
      );

  final String host;
  @JsonKey(includeIfNull: false)
  final int? port;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDictToJson(
        this,
      );
}
