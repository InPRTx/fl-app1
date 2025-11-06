// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_user_group_host_dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeUserGroupHostDict _$SsNodeUserGroupHostDictFromJson(
  Map<String, dynamic> json,
) => SsNodeUserGroupHostDict(
  host: json['host'] as String,
  port: (json['port'] as num?)?.toInt(),
);

Map<String, dynamic> _$SsNodeUserGroupHostDictToJson(
  SsNodeUserGroupHostDict instance,
) => <String, dynamic>{'host': instance.host, 'port': ?instance.port};
