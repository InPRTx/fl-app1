// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'ss_node_output.dart';

part 'get_ss_node_list_response.g.dart';

@JsonSerializable()
class GetSsNodeListResponse {
  const GetSsNodeListResponse({
    this.isSuccess = true,
    this.message = '获取成功',
    this.resultList = const [],
  });

  factory GetSsNodeListResponse.fromJson(Map<String, Object?> json) =>
      _$GetSsNodeListResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 节点列表
  @JsonKey(name: 'result_list')
  final List<SsNodeOutput> resultList;

  Map<String, Object?> toJson() => _$GetSsNodeListResponseToJson(this);
}
