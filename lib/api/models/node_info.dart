// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'node_info.g.dart';

@JsonSerializable()
class NodeInfo {
  const NodeInfo({
    required this.nodeId,
    required this.nodeName,
    required this.serverAddress,
    required this.location,
    required this.countryCode,
    required this.load,
    required this.status,
    required this.protocolSupport,
    required this.bandwidth,
    required this.isPremium,
    this.ping,
  });

  factory NodeInfo.fromJson(Map<String, Object?> json) =>
      _$NodeInfoFromJson(json);

  /// 节点ID
  @JsonKey(name: 'node_id')
  final int nodeId;

  /// 节点名称
  @JsonKey(name: 'node_name')
  final String nodeName;

  /// 服务器地址
  @JsonKey(name: 'server_address')
  final String serverAddress;

  /// 节点位置
  final String location;

  /// 国家代码
  @JsonKey(name: 'country_code')
  final String countryCode;

  /// 延迟(ms)
  @JsonKey(includeIfNull: false)
  final int? ping;

  /// 负载百分比
  final num load;

  /// 节点状态
  final String status;

  /// 支持的协议
  @JsonKey(name: 'protocol_support')
  final List<String> protocolSupport;

  /// 带宽信息
  final String bandwidth;

  /// 是否为高级节点
  @JsonKey(name: 'is_premium')
  final bool isPremium;

  Map<String, Object?> toJson() => _$NodeInfoToJson(this);
}
