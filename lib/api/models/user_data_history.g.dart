// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataHistory _$UserDataHistoryFromJson(Map<String, dynamic> json) =>
    UserDataHistory(
      userId: (json['user_id'] as num).toInt(),
      ssUploadSize: (json['ss_upload_size'] as num).toInt(),
      ssDownloadSize: (json['ss_download_size'] as num).toInt(),
      ssBandwidthTotalSize: (json['ss_bandwidth_total_size'] as num).toInt(),
      moneyAmount: json['money_amount'] as String,
      userLevelExpireIn: DateTime.parse(json['user_level_expire_in'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserDataHistoryToJson(UserDataHistory instance) =>
    <String, dynamic>{
      'created_at': ?instance.createdAt?.toIso8601String(),
      'user_id': instance.userId,
      'ss_upload_size': instance.ssUploadSize,
      'ss_download_size': instance.ssDownloadSize,
      'ss_bandwidth_total_size': instance.ssBandwidthTotalSize,
      'money_amount': instance.moneyAmount,
      'user_level_expire_in': instance.userLevelExpireIn.toIso8601String(),
    };
