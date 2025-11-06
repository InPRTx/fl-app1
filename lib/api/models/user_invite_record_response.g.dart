// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_invite_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInviteRecordResponse _$UserInviteRecordResponseFromJson(
  Map<String, dynamic> json,
) => UserInviteRecordResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserInviteRecordResponseToJson(
  UserInviteRecordResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
