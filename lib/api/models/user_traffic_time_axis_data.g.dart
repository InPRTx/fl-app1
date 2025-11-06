// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_traffic_time_axis_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTrafficTimeAxisData _$UserTrafficTimeAxisDataFromJson(
  Map<String, dynamic> json,
) => UserTrafficTimeAxisData(
  userId: (json['user_id'] as num).toInt(),
  dataTimeRangeLower: DateTime.parse(json['data_time_range_lower'] as String),
  ssTxSize: (json['ss_tx_size'] as num).toInt(),
  ssRxSize: (json['ss_rx_size'] as num).toInt(),
  totalTraffic: (json['total_traffic'] as num).toInt(),
  trafficGb: json['traffic_gb'] as num,
  timestampMs: (json['timestamp_ms'] as num).toInt(),
);

Map<String, dynamic> _$UserTrafficTimeAxisDataToJson(
  UserTrafficTimeAxisData instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'data_time_range_lower': instance.dataTimeRangeLower.toIso8601String(),
  'ss_tx_size': instance.ssTxSize,
  'ss_rx_size': instance.ssRxSize,
  'total_traffic': instance.totalTraffic,
  'traffic_gb': instance.trafficGb,
  'timestamp_ms': instance.timestampMs,
};
