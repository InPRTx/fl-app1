// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'old_service_info.g.dart';

@JsonSerializable()
class OldServiceInfo {
  const OldServiceInfo({
    required this.userLevelText,
    required this.trafficLogToken,
    required this.otherEmbyUuid,
    required this.ssPasswd,
    required this.ssUuid,
    required this.userLevelExpireIn,
    required this.userAccountExpireIn,
    required this.ssUploadSize,
    required this.ssDownloadSize,
    required this.ssBandwidthTotalSize,
    this.subLink = const [],
    this.ssBandwidthYesterdayUsedSize = 0,
    this.ssBandwidthTodayUsedSize = 0,
    this.isLinkBurnAfter = false,
    this.onlineIpLimit,
    this.speedLimit,
  });

  factory OldServiceInfo.fromJson(Map<String, Object?> json) =>
      _$OldServiceInfoFromJson(json);

  /// 用户等级，直接输出等级
  @JsonKey(name: 'user_level_text')
  final String userLevelText;

  /// 用户当前在线IP限制
  @JsonKey(includeIfNull: false, name: 'online_ip_limit')
  final int? onlineIpLimit;

  /// 用户当前在线IP限制
  @JsonKey(includeIfNull: false, name: 'speed_limit')
  final String? speedLimit;

  /// 第一个为主要链接，第二个为备用链接
  @JsonKey(name: 'sub_link')
  final List<String> subLink;

  /// 用户流量日志Token
  @JsonKey(name: 'traffic_log_token')
  final String trafficLogToken;

  /// 其他家Emby UUID
  @JsonKey(name: 'other_emby_uuid')
  final String otherEmbyUuid;

  /// 用户旧版SS密码
  @JsonKey(name: 'ss_passwd')
  final String ssPasswd;

  /// 用户旧版VMESS UUID
  @JsonKey(name: 'ss_uuid')
  final String ssUuid;

  /// 等级过期时间 class_expire
  @JsonKey(name: 'user_level_expire_in')
  final DateTime userLevelExpireIn;

  /// 用户账户过期时间 expire_in
  @JsonKey(name: 'user_account_expire_in')
  final DateTime userAccountExpireIn;

  /// 上传数量 u
  @JsonKey(name: 'ss_upload_size')
  final int ssUploadSize;

  /// 下载数量 d
  @JsonKey(name: 'ss_download_size')
  final int ssDownloadSize;

  /// 流量总数
  @JsonKey(name: 'ss_bandwidth_total_size')
  final int ssBandwidthTotalSize;

  /// 昨天使用的流量数量 last_day_t
  @JsonKey(name: 'ss_bandwidth_yesterday_used_size')
  final int ssBandwidthYesterdayUsedSize;

  /// 昨天使用的流量数量 last_day_t
  @JsonKey(name: 'ss_bandwidth_today_used_size')
  final int ssBandwidthTodayUsedSize;

  /// 订阅链接是否为阅后即焚
  @JsonKey(name: 'is_link_burn_after')
  final bool isLinkBurnAfter;

  Map<String, Object?> toJson() => _$OldServiceInfoToJson(this);
}
