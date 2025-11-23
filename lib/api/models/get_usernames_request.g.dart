// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_usernames_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsernamesRequest _$GetUsernamesRequestFromJson(Map<String, dynamic> json) =>
    GetUsernamesRequest(
      userIds: (json['user_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$GetUsernamesRequestToJson(
  GetUsernamesRequest instance,
) => <String, dynamic>{'user_ids': instance.userIds};
