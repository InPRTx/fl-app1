// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_old_service_param_model_put.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut
_$WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPutFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut(
  ssUploadSize: (json['ss_upload_size'] as num).toInt(),
  ssDownloadSize: (json['ss_download_size'] as num).toInt(),
  ssBandwidthTotalSize: (json['ss_bandwidth_total_size'] as num).toInt(),
  userLevelExpireIn: DateTime.parse(json['user_level_expire_in'] as String),
  ssBandwidthYesterdayUsedSize:
      (json['ss_bandwidth_yesterday_used_size'] as num?)?.toInt() ?? 0,
  userLevel: (json['user_level'] as num?)?.toInt() ?? 0,
  ssLastUsedTime: json['ss_last_used_time'] == null
      ? null
      : DateTime.parse(json['ss_last_used_time'] as String),
  nodeSpeedLimit: json['node_speed_limit'],
  nodeConnector: (json['node_connector'] as num?)?.toInt(),
  autoResetDay: (json['auto_reset_day'] as num?)?.toInt(),
  autoResetBandwidth: json['auto_reset_bandwidth'],
  lastCheckInTime: json['last_check_in_time'] == null
      ? null
      : DateTime.parse(json['last_check_in_time'] as String),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPutToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut instance,
) => <String, dynamic>{
  'ss_last_used_time': ?instance.ssLastUsedTime?.toIso8601String(),
  'ss_upload_size': instance.ssUploadSize,
  'ss_download_size': instance.ssDownloadSize,
  'ss_bandwidth_total_size': instance.ssBandwidthTotalSize,
  'ss_bandwidth_yesterday_used_size': instance.ssBandwidthYesterdayUsedSize,
  'user_level': instance.userLevel,
  'user_level_expire_in': instance.userLevelExpireIn.toIso8601String(),
  'node_speed_limit': ?instance.nodeSpeedLimit,
  'node_connector': ?instance.nodeConnector,
  'auto_reset_day': ?instance.autoResetDay,
  'auto_reset_bandwidth': ?instance.autoResetBandwidth,
  'last_check_in_time': ?instance.lastCheckInTime?.toIso8601String(),
};
