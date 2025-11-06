// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_subscribe_log_detail_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesSubscribeLogDetailRecordResponse
_$UserServicesSubscribeLogDetailRecordResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesSubscribeLogDetailRecordResponse(
  message: json['message'] as String,
  result: (json['result'] as List<dynamic>)
      .map((e) => UserTrafficRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesSubscribeLogDetailRecordResponseToJson(
  UserServicesSubscribeLogDetailRecordResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
