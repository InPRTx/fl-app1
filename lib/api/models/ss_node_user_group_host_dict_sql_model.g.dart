// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_user_group_host_dict_sql_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeUserGroupHostDictSqlModel _$SsNodeUserGroupHostDictSqlModelFromJson(
  Map<String, dynamic> json,
) => SsNodeUserGroupHostDictSqlModel(
  host: json['host'] as String,
  port: (json['port'] as num?)?.toInt(),
);

Map<String, dynamic> _$SsNodeUserGroupHostDictSqlModelToJson(
  SsNodeUserGroupHostDictSqlModel instance,
) => <String, dynamic>{'host': instance.host, 'port': ?instance.port};
