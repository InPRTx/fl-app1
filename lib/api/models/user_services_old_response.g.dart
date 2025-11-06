// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_old_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesOldResponse _$UserServicesOldResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesOldResponse(
  result:
      WebSubFastapiRoutersApiVUserServicesOldIndexUserServicesOldResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserServicesOldResponseToJson(
  UserServicesOldResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
