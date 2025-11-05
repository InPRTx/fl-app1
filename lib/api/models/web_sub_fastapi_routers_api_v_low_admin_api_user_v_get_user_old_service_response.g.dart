// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_v_get_user_old_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse
_$WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponseFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse(
  result: json['result'] == null
      ? null
      : AdminUserV.fromJson(json['result'] as Map<String, dynamic>),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponseToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
