// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_services_nodes_index_user_services_nodes_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult
_$WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult(
      totalNodes: (json['total_nodes'] as num).toInt(),
      availableNodes: (json['available_nodes'] as List<dynamic>)
          .map((e) => NodeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      userTier: json['user_tier'] as String,
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResultToJson(
  WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult
  instance,
) => <String, dynamic>{
  'total_nodes': instance.totalNodes,
  'available_nodes': instance.availableNodes,
  'user_tier': instance.userTier,
};
