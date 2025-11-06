// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_invite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInviteResponse _$UserInviteResponseFromJson(
  Map<String, dynamic> json,
) => UserInviteResponse(
  result:
      WebSubFastapiRoutersApiVUserInviteIndexUserInviteResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserInviteResponseToJson(UserInviteResponse instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'result': instance.result,
    };
