// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_user_group_host_dict_sql_model.dart';

part 'ss_node_user_group_host_sql_model.g.dart';

/// 用户组主机映射（SQLModel 版本）
@JsonSerializable()
class SsNodeUserGroupHostSqlModel {
  const SsNodeUserGroupHostSqlModel({required this.userGroupHost});

  factory SsNodeUserGroupHostSqlModel.fromJson(Map<String, Object?> json) =>
      _$SsNodeUserGroupHostSqlModelFromJson(json);

  @JsonKey(name: 'user_group_host')
  final Map<String, SsNodeUserGroupHostDictSqlModel> userGroupHost;

  Map<String, Object?> toJson() => _$SsNodeUserGroupHostSqlModelToJson(this);
}
