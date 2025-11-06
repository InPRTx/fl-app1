// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_services_nodes_index_user_services_nodes_response_result.dart';

part 'user_services_nodes_response.g.dart';

@JsonSerializable()
class UserServicesNodesResponse {
  const UserServicesNodesResponse({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserServicesNodesResponse.fromJson(Map<String, Object?> json) =>
      _$UserServicesNodesResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户节点信息
  final WebSubFastapiRoutersApiVUserServicesNodesIndexUserServicesNodesResponseResult
  result;

  Map<String, Object?> toJson() => _$UserServicesNodesResponseToJson(this);
}
