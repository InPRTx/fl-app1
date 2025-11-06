// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_traffic_calendar_data.g.dart';

/// 用户流量日历数据模型
@JsonSerializable()
class UserTrafficCalendarData {
  const UserTrafficCalendarData({
    required this.userId,
    required this.dataTimeRangeLower,
    required this.ssTxSize,
    required this.ssRxSize,
    required this.totalTraffic,
    required this.trafficGb,
  });

  factory UserTrafficCalendarData.fromJson(Map<String, Object?> json) =>
      _$UserTrafficCalendarDataFromJson(json);

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 数据时间范围下限
  @JsonKey(name: 'data_time_range_lower')
  final DateTime dataTimeRangeLower;

  /// 上传流量大小(字节)
  @JsonKey(name: 'ss_tx_size')
  final int ssTxSize;

  /// 下载流量大小(字节)
  @JsonKey(name: 'ss_rx_size')
  final int ssRxSize;

  /// 总流量大小(字节)
  @JsonKey(name: 'total_traffic')
  final int totalTraffic;

  /// 总流量(GB)
  @JsonKey(name: 'traffic_gb')
  final num trafficGb;

  Map<String, Object?> toJson() => _$UserTrafficCalendarDataToJson(this);
}
