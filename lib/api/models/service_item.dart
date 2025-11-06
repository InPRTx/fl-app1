// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'service_item.g.dart';

@JsonSerializable()
class ServiceItem {
  const ServiceItem({
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    required this.status,
    required this.createdAt,
    required this.expireAt,
    required this.trafficUsed,
    required this.trafficTotal,
    required this.port,
    required this.password,
  });

  factory ServiceItem.fromJson(Map<String, Object?> json) =>
      _$ServiceItemFromJson(json);

  /// 服务ID
  @JsonKey(name: 'service_id')
  final int serviceId;

  /// 服务名称
  @JsonKey(name: 'service_name')
  final String serviceName;

  /// 服务类型
  @JsonKey(name: 'service_type')
  final String serviceType;

  /// 服务状态
  final String status;

  /// 创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 到期时间
  @JsonKey(name: 'expire_at')
  final DateTime expireAt;

  /// 已用流量(字节)
  @JsonKey(name: 'traffic_used')
  final int trafficUsed;

  /// 总流量(字节)
  @JsonKey(name: 'traffic_total')
  final int trafficTotal;

  /// 端口号
  final int port;

  /// 连接密码
  final String password;

  Map<String, Object?> toJson() => _$ServiceItemToJson(this);
}
