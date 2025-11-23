// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_output.dart';

part 'get_ss_node_response.g.dart';

@JsonSerializable()
class GetSsNodeResponse {
  const GetSsNodeResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory GetSsNodeResponse.fromJson(Map<String, Object?> json) =>
      _$GetSsNodeResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 节点信息
  @JsonKey(includeIfNull: false)
  final SsNodeOutput? result;

  Map<String, Object?> toJson() => _$GetSsNodeResponseToJson(this);
}
