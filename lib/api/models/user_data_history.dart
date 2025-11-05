// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_data_history.g.dart';

@JsonSerializable()
class UserDataHistory {
  const UserDataHistory({
    required this.userId,
    required this.ssUploadSize,
    required this.ssDownloadSize,
    required this.ssBandwidthTotalSize,
    required this.moneyAmount,
    required this.userLevelExpireIn,
    this.createdAt,
  });

  factory UserDataHistory.fromJson(Map<String, Object?> json) =>
      _$UserDataHistoryFromJson(json);

  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'ss_upload_size')
  final int ssUploadSize;
  @JsonKey(name: 'ss_download_size')
  final int ssDownloadSize;
  @JsonKey(name: 'ss_bandwidth_total_size')
  final int ssBandwidthTotalSize;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;
  @JsonKey(name: 'user_level_expire_in')
  final DateTime userLevelExpireIn;

  Map<String, Object?> toJson() => _$UserDataHistoryToJson(this);
}
