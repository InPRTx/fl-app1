// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_traffic_time_axis_data.dart';

part 'user_services_subscribe_log_area_time_axis_response.g.dart';

@JsonSerializable()
class UserServicesSubscribeLogAreaTimeAxisResponse {
  const UserServicesSubscribeLogAreaTimeAxisResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserServicesSubscribeLogAreaTimeAxisResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesSubscribeLogAreaTimeAxisResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 订阅日志区域时间轴数据
  final List<UserTrafficTimeAxisData> result;

  Map<String, Object?> toJson() =>
      _$UserServicesSubscribeLogAreaTimeAxisResponseToJson(this);
}
