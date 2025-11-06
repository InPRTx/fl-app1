// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_services_nodes_node_id_response.g.dart';

@JsonSerializable()
class UserServicesNodesNodeIdResponse {
  const UserServicesNodesNodeIdResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserServicesNodesNodeIdResponse.fromJson(Map<String, Object?> json) =>
      _$UserServicesNodesNodeIdResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 节点详情
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserServicesNodesNodeIdResponseToJson(this);
}
