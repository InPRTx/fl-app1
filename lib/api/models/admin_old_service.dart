// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'admin_old_service.g.dart';

@JsonSerializable()
class AdminOldService {
  const AdminOldService({
    required this.ssUploadSize,
    required this.ssDownloadSize,
    required this.ssBandwidthTotalSize,
    required this.userLevelExpireIn,
    this.ssBandwidthYesterdayUsedSize = 0,
    this.userLevel = 0,
    this.nodeConnector = 0,
    this.autoResetDay = 0,
    this.autoResetBandwidth = '0.0',
    this.ssLastUsedTime,
    this.nodeSpeedLimit,
    this.lastCheckInTime,
  });

  factory AdminOldService.fromJson(Map<String, Object?> json) =>
      _$AdminOldServiceFromJson(json);

  /// 最后使用时间 t
  @JsonKey(includeIfNull: false, name: 'ss_last_used_time')
  final DateTime? ssLastUsedTime;

  /// 上传数量 u
  @JsonKey(name: 'ss_upload_size')
  final int ssUploadSize;

  /// 下载数量 d
  @JsonKey(name: 'ss_download_size')
  final int ssDownloadSize;

  /// transfer_enable
  @JsonKey(name: 'ss_bandwidth_total_size')
  final int ssBandwidthTotalSize;

  /// 昨天使用的流量数量 last_day_t
  @JsonKey(name: 'ss_bandwidth_yesterday_used_size')
  final int ssBandwidthYesterdayUsedSize;

  /// class
  @JsonKey(name: 'user_level')
  final int userLevel;

  /// 等级过期时间 class_expire
  @JsonKey(name: 'user_level_expire_in')
  final DateTime userLevelExpireIn;
  @JsonKey(includeIfNull: false, name: 'node_speed_limit')
  final String? nodeSpeedLimit;

  /// 用户在线设备数量
  @JsonKey(includeIfNull: true, name: 'node_connector')
  final int? nodeConnector;

  /// 旧版 自动重置流量日
  @JsonKey(includeIfNull: true, name: 'auto_reset_day')
  final int? autoResetDay;

  /// 旧版 重置流量值
  @JsonKey(includeIfNull: true, name: 'auto_reset_bandwidth')
  final String? autoResetBandwidth;

  /// 最后签到时间
  @JsonKey(includeIfNull: false, name: 'last_check_in_time')
  final DateTime? lastCheckInTime;

  Map<String, Object?> toJson() => _$AdminOldServiceToJson(this);
}
