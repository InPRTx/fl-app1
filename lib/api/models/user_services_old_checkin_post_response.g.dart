// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_old_checkin_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesOldCheckinPostResponse _$UserServicesOldCheckinPostResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesOldCheckinPostResponse(
  message: json['message'] as String,
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesOldCheckinPostResponseToJson(
  UserServicesOldCheckinPostResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
};
