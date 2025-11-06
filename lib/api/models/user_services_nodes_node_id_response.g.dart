// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_nodes_node_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesNodesNodeIdResponse _$UserServicesNodesNodeIdResponseFromJson(
  Map<String, dynamic> json,
) => UserServicesNodesNodeIdResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserServicesNodesNodeIdResponseToJson(
  UserServicesNodesNodeIdResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
