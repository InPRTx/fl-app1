// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_nodes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesNodesResponse _$UserServicesNodesResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesNodesResponse(
  result:
      WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserServicesNodesResponseToJson(
  UserServicesNodesResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
