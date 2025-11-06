// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_traffic_record.dart';

part 'user_services_subscribe_log_detail_record_response.g.dart';

@JsonSerializable()
class UserServicesSubscribeLogDetailRecordResponse {
  const UserServicesSubscribeLogDetailRecordResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserServicesSubscribeLogDetailRecordResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesSubscribeLogDetailRecordResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 订阅日志详细记录数据
  final List<UserTrafficRecord> result;

  Map<String, Object?> toJson() =>
      _$UserServicesSubscribeLogDetailRecordResponseToJson(this);
}
