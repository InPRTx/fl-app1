// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_subscribe_log_area_time_axis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesSubscribeLogAreaTimeAxisResponse
_$UserServicesSubscribeLogAreaTimeAxisResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesSubscribeLogAreaTimeAxisResponse(
  message: json['message'] as String,
  result: (json['result'] as List<dynamic>)
      .map((e) => UserTrafficTimeAxisData.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesSubscribeLogAreaTimeAxisResponseToJson(
  UserServicesSubscribeLogAreaTimeAxisResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
