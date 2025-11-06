// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_get_old_service_get_old_service_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult
_$WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult(
  serviceId: (json['service_id'] as num).toInt(),
  serviceName: json['service_name'] as String,
  serviceType: json['service_type'] as String,
  expireTime: DateTime.parse(json['expire_time'] as String),
  trafficUsed: (json['traffic_used'] as num).toInt(),
  trafficTotal: (json['traffic_total'] as num).toInt(),
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResultToJson(
  WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult
  instance,
) => <String, dynamic>{
  'service_id': instance.serviceId,
  'service_name': instance.serviceName,
  'service_type': instance.serviceType,
  'expire_time': instance.expireTime.toIso8601String(),
  'traffic_used': instance.trafficUsed,
  'traffic_total': instance.trafficTotal,
  'is_active': instance.isActive,
};
