// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_old_bill_service_id_enable_auto_renewal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesOldBillServiceIdEnableAutoRenewalResponse
_$UserServicesOldBillServiceIdEnableAutoRenewalResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesOldBillServiceIdEnableAutoRenewalResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic>
_$UserServicesOldBillServiceIdEnableAutoRenewalResponseToJson(
  UserServicesOldBillServiceIdEnableAutoRenewalResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
