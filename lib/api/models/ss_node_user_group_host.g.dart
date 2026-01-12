// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_node_user_group_host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsNodeUserGroupHost _$SsNodeUserGroupHostFromJson(Map<String, dynamic> json) =>
    SsNodeUserGroupHost(
      userGroupHost: (json['user_group_host'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          SsNodeUserGroupHostDict.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );

Map<String, dynamic> _$SsNodeUserGroupHostToJson(
  SsNodeUserGroupHost instance,
) => <String, dynamic>{'user_group_host': instance.userGroupHost};
