// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_group_host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGroupHost _$UserGroupHostFromJson(Map<String, dynamic> json) =>
    UserGroupHost(
      userGroupHost: (json['user_group_host'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          SsNodeUserGroupHostDict.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );

Map<String, dynamic> _$UserGroupHostToJson(UserGroupHost instance) =>
    <String, dynamic>{'user_group_host': instance.userGroupHost};
