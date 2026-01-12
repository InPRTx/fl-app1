// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_user_group_host_dict.dart';

part 'ss_node_user_group_host.g.dart';

/// 用户组主机映射
@JsonSerializable()
class SsNodeUserGroupHost {
  const SsNodeUserGroupHost({required this.userGroupHost});

  factory SsNodeUserGroupHost.fromJson(Map<String, Object?> json) =>
      _$SsNodeUserGroupHostFromJson(json);

  @JsonKey(name: 'user_group_host')
  final Map<String, SsNodeUserGroupHostDict> userGroupHost;

  Map<String, Object?> toJson() => _$SsNodeUserGroupHostToJson(this);
}
