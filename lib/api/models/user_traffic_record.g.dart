// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_traffic_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTrafficRecord _$UserTrafficRecordFromJson(Map<String, dynamic> json) =>
    UserTrafficRecord(
      userId: (json['user_id'] as num).toInt(),
      nodeId: (json['node_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      ssTxSize: (json['ss_tx_size'] as num).toInt(),
      ssRxSize: (json['ss_rx_size'] as num).toInt(),
      nodeRate: json['node_rate'] as String,
      totalTraffic: (json['total_traffic'] as num).toInt(),
      effectiveTraffic: (json['effective_traffic'] as num).toInt(),
      nodeName: json['node_name'] as String?,
    );

Map<String, dynamic> _$UserTrafficRecordToJson(UserTrafficRecord instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'node_id': instance.nodeId,
      'node_name': ?instance.nodeName,
      'created_at': instance.createdAt.toIso8601String(),
      'ss_tx_size': instance.ssTxSize,
      'ss_rx_size': instance.ssRxSize,
      'node_rate': instance.nodeRate,
      'total_traffic': instance.totalTraffic,
      'effective_traffic': instance.effectiveTraffic,
    };
