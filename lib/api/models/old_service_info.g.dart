// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'old_service_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OldServiceInfo _$OldServiceInfoFromJson(
  Map<String, dynamic> json,
) => OldServiceInfo(
  userLevelText: json['user_level_text'] as String,
  trafficLogToken: json['traffic_log_token'] as String,
  otherEmbyUuid: json['other_emby_uuid'] as String,
  ssPasswd: json['ss_passwd'] as String,
  ssUuid: json['ss_uuid'] as String,
  userLevelExpireIn: DateTime.parse(json['user_level_expire_in'] as String),
  userAccountExpireIn: DateTime.parse(json['user_account_expire_in'] as String),
  ssUploadSize: (json['ss_upload_size'] as num).toInt(),
  ssDownloadSize: (json['ss_download_size'] as num).toInt(),
  ssBandwidthTotalSize: (json['ss_bandwidth_total_size'] as num).toInt(),
  subLink:
      (json['sub_link'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  ssBandwidthYesterdayUsedSize:
      (json['ss_bandwidth_yesterday_used_size'] as num?)?.toInt() ?? 0,
  ssBandwidthTodayUsedSize:
      (json['ss_bandwidth_today_used_size'] as num?)?.toInt() ?? 0,
  isLinkBurnAfter: json['is_link_burn_after'] as bool? ?? false,
  onlineIpLimit: (json['online_ip_limit'] as num?)?.toInt(),
  speedLimit: json['speed_limit'] as String?,
);

Map<String, dynamic> _$OldServiceInfoToJson(OldServiceInfo instance) =>
    <String, dynamic>{
      'user_level_text': instance.userLevelText,
      'online_ip_limit': ?instance.onlineIpLimit,
      'speed_limit': ?instance.speedLimit,
      'sub_link': instance.subLink,
      'traffic_log_token': instance.trafficLogToken,
      'other_emby_uuid': instance.otherEmbyUuid,
      'ss_passwd': instance.ssPasswd,
      'ss_uuid': instance.ssUuid,
      'user_level_expire_in': instance.userLevelExpireIn.toIso8601String(),
      'user_account_expire_in': instance.userAccountExpireIn.toIso8601String(),
      'ss_upload_size': instance.ssUploadSize,
      'ss_download_size': instance.ssDownloadSize,
      'ss_bandwidth_total_size': instance.ssBandwidthTotalSize,
      'ss_bandwidth_yesterday_used_size': instance.ssBandwidthYesterdayUsedSize,
      'ss_bandwidth_today_used_size': instance.ssBandwidthTodayUsedSize,
      'is_link_burn_after': instance.isLinkBurnAfter,
    };
