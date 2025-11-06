// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_audit_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesAuditRecordResponse _$UserServicesAuditRecordResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesAuditRecordResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesAuditRecordResponseToJson(
  UserServicesAuditRecordResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
