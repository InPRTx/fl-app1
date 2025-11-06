// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_traffic_record.g.dart';

/// 用户流量记录模型
@JsonSerializable()
class UserTrafficRecord {
  const UserTrafficRecord({
    required this.userId,
    required this.nodeId,
    required this.createdAt,
    required this.ssTxSize,
    required this.ssRxSize,
    required this.nodeRate,
    required this.totalTraffic,
    required this.effectiveTraffic,
    this.nodeName,
  });

  factory UserTrafficRecord.fromJson(Map<String, Object?> json) =>
      _$UserTrafficRecordFromJson(json);

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 节点ID
  @JsonKey(name: 'node_id')
  final int nodeId;

  /// 节点名称
  @JsonKey(includeIfNull: false, name: 'node_name')
  final String? nodeName;

  /// 记录创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 上传流量大小(字节)
  @JsonKey(name: 'ss_tx_size')
  final int ssTxSize;

  /// 下载流量大小(字节)
  @JsonKey(name: 'ss_rx_size')
  final int ssRxSize;

  /// 节点倍率
  @JsonKey(name: 'node_rate')
  final String nodeRate;

  /// 总流量大小(字节)
  @JsonKey(name: 'total_traffic')
  final int totalTraffic;

  /// 有效流量大小(字节，考虑倍率)
  @JsonKey(name: 'effective_traffic')
  final int effectiveTraffic;

  Map<String, Object?> toJson() => _$UserTrafficRecordToJson(this);
}
