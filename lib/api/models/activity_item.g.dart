// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityItem _$ActivityItemFromJson(Map<String, dynamic> json) => ActivityItem(
  activityId: (json['activity_id'] as num).toInt(),
  activityType: json['activity_type'] as String,
  description: json['description'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  ipAddress: json['ip_address'] as String,
);

Map<String, dynamic> _$ActivityItemToJson(ActivityItem instance) =>
    <String, dynamic>{
      'activity_id': instance.activityId,
      'activity_type': instance.activityType,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'ip_address': instance.ipAddress,
    };
