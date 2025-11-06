// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'node_info.dart';

part 'web_sub_fastapi_routers_api_v_user_services_nodes_index_user_services_nodes_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult {
  const WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult({
    required this.totalNodes,
    required this.availableNodes,
    required this.userTier,
  });

  factory WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResultFromJson(
        json,
      );

  /// 节点总数
  @JsonKey(name: 'total_nodes')
  final int totalNodes;

  /// 可用节点列表
  @JsonKey(name: 'available_nodes')
  final List<NodeInfo> availableNodes;

  /// 用户等级
  @JsonKey(name: 'user_tier')
  final String userTier;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResultToJson(
        this,
      );
}
