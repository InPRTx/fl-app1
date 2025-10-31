// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'ss_node_user_group_host_dict.g.dart';

@JsonSerializable()
class SsNodeUserGroupHostDict {
  const SsNodeUserGroupHostDict({
    required this.host,
    this.port,
  });

  factory SsNodeUserGroupHostDict.fromJson(Map<String, Object?> json) =>
      _$SsNodeUserGroupHostDictFromJson(json);
  
  final String host;
  final int? port;

  Map<String, Object?> toJson() => _$SsNodeUserGroupHostDictToJson(this);
}
