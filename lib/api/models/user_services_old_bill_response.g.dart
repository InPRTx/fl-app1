// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_old_bill_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesOldBillResponse _$UserServicesOldBillResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesOldBillResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesOldBillResponseToJson(
  UserServicesOldBillResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
