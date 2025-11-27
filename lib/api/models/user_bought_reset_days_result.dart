// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_bought_reset_days_result.g.dart';

/// 套餐流量重置日信息
@JsonSerializable()
class UserBoughtResetDaysResult {
  const UserBoughtResetDaysResult({
    required this.boughtId,
    required this.shopId,
    required this.shopName,
    required this.createdAt,
    required this.expiresAt,
    required this.userLevelDurationDays,
    required this.ssBandwidthResetIntervalDays,
    required this.daysSincePurchase,
    required this.daysUntilReset,
    required this.nextResetDate,
    required this.isResetDayToday,
    required this.totalResetCount,
    required this.allResetDates,
    required this.pastResetDates,
    required this.futureResetDates,
    required this.pastActualResetExecutionDates,
    required this.futureActualResetExecutionDates,
  });

  factory UserBoughtResetDaysResult.fromJson(Map<String, Object?> json) =>
      _$UserBoughtResetDaysResultFromJson(json);

  /// 购买记录ID
  @JsonKey(name: 'bought_id')
  final String boughtId;

  /// 商品ID
  @JsonKey(name: 'shop_id')
  final int shopId;

  /// 商品名称
  @JsonKey(includeIfNull: true, name: 'shop_name')
  final String? shopName;

  /// 购买时间
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// 过期时间
  @JsonKey(name: 'expires_at')
  final String expiresAt;

  /// 套餐有效期(天)
  @JsonKey(name: 'user_level_duration_days')
  final int userLevelDurationDays;

  /// 流量重置周期(天)
  @JsonKey(name: 'ss_bandwidth_reset_interval_days')
  final int ssBandwidthResetIntervalDays;

  /// 购买后经过的天数（基于今天零点）
  @JsonKey(name: 'days_since_purchase')
  final int daysSincePurchase;

  /// 距离下次重置的天数
  @JsonKey(name: 'days_until_reset')
  final int daysUntilReset;

  /// 下次流量重置日期（购买时间+N天）
  @JsonKey(name: 'next_reset_date')
  final String nextResetDate;

  /// 今天是否为重置日（daily_job 今天 00:00 是否执行重置）
  @JsonKey(name: 'is_reset_day_today')
  final bool isResetDayToday;

  /// 已发生的重置次数（包括购买当天）
  @JsonKey(name: 'total_reset_count')
  final int totalResetCount;

  /// 所有重置日期列表（购买时间+N*周期）
  @JsonKey(name: 'all_reset_dates')
  final List<String> allResetDates;

  /// 已经发生的重置日期
  @JsonKey(name: 'past_reset_dates')
  final List<String> pastResetDates;

  /// 未来的重置日期（到过期为止）
  @JsonKey(name: 'future_reset_dates')
  final List<String> futureResetDates;

  /// daily_job 已执行的重置日期（每天 00:00）
  @JsonKey(name: 'past_actual_reset_execution_dates')
  final List<String> pastActualResetExecutionDates;

  /// daily_job 未来将执行的重置日期（每天 00:00）
  @JsonKey(name: 'future_actual_reset_execution_dates')
  final List<String> futureActualResetExecutionDates;

  Map<String, Object?> toJson() => _$UserBoughtResetDaysResultToJson(this);
}
