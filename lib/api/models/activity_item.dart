// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'activity_item.g.dart';

@JsonSerializable()
class ActivityItem {
  const ActivityItem({
    required this.activityId,
    required this.activityType,
    required this.description,
    required this.timestamp,
    required this.ipAddress,
  });

  factory ActivityItem.fromJson(Map<String, Object?> json) =>
      _$ActivityItemFromJson(json);

  /// 活动ID
  @JsonKey(name: 'activity_id')
  final int activityId;

  /// 活动类型
  @JsonKey(name: 'activity_type')
  final String activityType;

  /// 活动描述
  final String description;

  /// 活动时间
  final DateTime timestamp;

  /// IP地址
  @JsonKey(name: 'ip_address')
  final String ipAddress;

  Map<String, Object?> toJson() => _$ActivityItemToJson(this);
}
