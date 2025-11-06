// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_traffic_calendar_data.dart';

part 'user_services_subscribe_log_calendar_pie_response.g.dart';

@JsonSerializable()
class UserServicesSubscribeLogCalendarPieResponse {
  const UserServicesSubscribeLogCalendarPieResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserServicesSubscribeLogCalendarPieResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesSubscribeLogCalendarPieResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 订阅日志日历饼图数据
  final List<UserTrafficCalendarData> result;

  Map<String, Object?> toJson() =>
      _$UserServicesSubscribeLogCalendarPieResponseToJson(this);
}
