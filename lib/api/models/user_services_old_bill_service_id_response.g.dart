// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_old_bill_service_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesOldBillServiceIdResponse
_$UserServicesOldBillServiceIdResponseFromJson(Map<String, dynamic> json) =>
    UserServicesOldBillServiceIdResponse(
      message: json['message'] as String,
      result: json['result'],
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserServicesOldBillServiceIdResponseToJson(
  UserServicesOldBillServiceIdResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
