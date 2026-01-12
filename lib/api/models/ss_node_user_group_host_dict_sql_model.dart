// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'ss_node_user_group_host_dict_sql_model.g.dart';

/// 用户组主机配置（SQLModel 版本）
@JsonSerializable()
class SsNodeUserGroupHostDictSqlModel {
  const SsNodeUserGroupHostDictSqlModel({required this.host, this.port});

  factory SsNodeUserGroupHostDictSqlModel.fromJson(Map<String, Object?> json) =>
      _$SsNodeUserGroupHostDictSqlModelFromJson(json);

  final String host;
  @JsonKey(includeIfNull: false)
  final int? port;

  Map<String, Object?> toJson() =>
      _$SsNodeUserGroupHostDictSqlModelToJson(this);
}
