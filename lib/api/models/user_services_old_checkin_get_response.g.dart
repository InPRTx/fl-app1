// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_old_checkin_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesOldCheckinGetResponse _$UserServicesOldCheckinGetResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesOldCheckinGetResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesOldCheckinGetResponseToJson(
  UserServicesOldCheckinGetResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
