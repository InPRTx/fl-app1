// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_user_group_host_sql_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeUserGroupHostSqlModel _$SsNodeUserGroupHostSqlModelFromJson(
  Map<String, dynamic> json,
) => SsNodeUserGroupHostSqlModel(
  userGroupHost: (json['user_group_host'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      SsNodeUserGroupHostDictSqlModel.fromJson(e as Map<String, dynamic>),
    ),
  ),
);

Map<String, dynamic> _$SsNodeUserGroupHostSqlModelToJson(
  SsNodeUserGroupHostSqlModel instance,
) => <String, dynamic>{'user_group_host': instance.userGroupHost};
