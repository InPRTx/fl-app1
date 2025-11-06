// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_subscribe_log_calendar_pie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesSubscribeLogCalendarPieResponse
_$UserServicesSubscribeLogCalendarPieResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesSubscribeLogCalendarPieResponse(
  message: json['message'] as String,
  result: (json['result'] as List<dynamic>)
      .map((e) => UserTrafficCalendarData.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesSubscribeLogCalendarPieResponseToJson(
  UserServicesSubscribeLogCalendarPieResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
