// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_get_old_service_get_old_service_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult {
  const WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult({
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    required this.expireTime,
    required this.trafficUsed,
    required this.trafficTotal,
    this.isActive = true,
  });

  factory WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResultFromJson(
        json,
      );

  /// 服务ID
  @JsonKey(name: 'service_id')
  final int serviceId;

  /// 服务名称
  @JsonKey(name: 'service_name')
  final String serviceName;

  /// 服务类型
  @JsonKey(name: 'service_type')
  final String serviceType;

  /// 服务到期时间
  @JsonKey(name: 'expire_time')
  final DateTime expireTime;

  /// 已用流量(字节)
  @JsonKey(name: 'traffic_used')
  final int trafficUsed;

  /// 总流量(字节)
  @JsonKey(name: 'traffic_total')
  final int trafficTotal;

  /// 服务是否激活
  @JsonKey(name: 'is_active')
  final bool isActive;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserGetOldServiceGetOldServiceResultModelResultToJson(
        this,
      );
}
