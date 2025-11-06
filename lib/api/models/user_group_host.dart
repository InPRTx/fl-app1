// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_user_group_host_dict.dart';

part 'user_group_host.g.dart';

@JsonSerializable()
class UserGroupHost {
  const UserGroupHost({required this.userGroupHost});

  factory UserGroupHost.fromJson(Map<String, Object?> json) =>
      _$UserGroupHostFromJson(json);

  @JsonKey(name: 'user_group_host')
  final Map<String, SsNodeUserGroupHostDict> userGroupHost;

  Map<String, Object?> toJson() => _$UserGroupHostToJson(this);
}
