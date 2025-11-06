// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceItem _$ServiceItemFromJson(Map<String, dynamic> json) => ServiceItem(
  serviceId: (json['service_id'] as num).toInt(),
  serviceName: json['service_name'] as String,
  serviceType: json['service_type'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  expireAt: DateTime.parse(json['expire_at'] as String),
  trafficUsed: (json['traffic_used'] as num).toInt(),
  trafficTotal: (json['traffic_total'] as num).toInt(),
  port: (json['port'] as num).toInt(),
  password: json['password'] as String,
);

Map<String, dynamic> _$ServiceItemToJson(ServiceItem instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'service_type': instance.serviceType,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'expire_at': instance.expireAt.toIso8601String(),
      'traffic_used': instance.trafficUsed,
      'traffic_total': instance.trafficTotal,
      'port': instance.port,
      'password': instance.password,
    };
