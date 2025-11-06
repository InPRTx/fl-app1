// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_old_service_get_user_old_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
_$WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponseFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse(
  result: json['result'] == null
      ? null
      : AdminOldService.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponseToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse
  instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
