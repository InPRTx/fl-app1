// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_audit_rule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesAuditRuleResponse _$UserServicesAuditRuleResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesAuditRuleResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesAuditRuleResponseToJson(
  UserServicesAuditRuleResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
