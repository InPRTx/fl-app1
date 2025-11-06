// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_pay_list_get_user_bought_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse
_$WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponseFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse(
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
  resultList:
      (json['result_list'] as List<dynamic>?)
          ?.map((e) => UserPayList.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponseToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result_list': instance.resultList,
};
