// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bought_reset_days_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBoughtResetDaysResult _$UserBoughtResetDaysResultFromJson(
  Map<String, dynamic> json,
) => UserBoughtResetDaysResult(
  boughtId: json['bought_id'] as String,
  shopId: (json['shop_id'] as num).toInt(),
  shopName: json['shop_name'] as String?,
  createdAt: json['created_at'] as String,
  expiresAt: json['expires_at'] as String,
  userLevelDurationDays: (json['user_level_duration_days'] as num).toInt(),
  ssBandwidthResetIntervalDays:
      (json['ss_bandwidth_reset_interval_days'] as num).toInt(),
  daysSincePurchase: (json['days_since_purchase'] as num).toInt(),
  daysUntilReset: (json['days_until_reset'] as num).toInt(),
  nextResetDate: json['next_reset_date'] as String,
  isResetDayToday: json['is_reset_day_today'] as bool,
  totalResetCount: (json['total_reset_count'] as num).toInt(),
  allResetDates: (json['all_reset_dates'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  pastResetDates: (json['past_reset_dates'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  futureResetDates: (json['future_reset_dates'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  pastActualResetExecutionDates:
      (json['past_actual_reset_execution_dates'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  futureActualResetExecutionDates:
      (json['future_actual_reset_execution_dates'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$UserBoughtResetDaysResultToJson(
  UserBoughtResetDaysResult instance,
) => <String, dynamic>{
  'bought_id': instance.boughtId,
  'shop_id': instance.shopId,
  'shop_name': instance.shopName,
  'created_at': instance.createdAt,
  'expires_at': instance.expiresAt,
  'user_level_duration_days': instance.userLevelDurationDays,
  'ss_bandwidth_reset_interval_days': instance.ssBandwidthResetIntervalDays,
  'days_since_purchase': instance.daysSincePurchase,
  'days_until_reset': instance.daysUntilReset,
  'next_reset_date': instance.nextResetDate,
  'is_reset_day_today': instance.isResetDayToday,
  'total_reset_count': instance.totalResetCount,
  'all_reset_dates': instance.allResetDates,
  'past_reset_dates': instance.pastResetDates,
  'future_reset_dates': instance.futureResetDates,
  'past_actual_reset_execution_dates': instance.pastActualResetExecutionDates,
  'future_actual_reset_execution_dates':
      instance.futureActualResetExecutionDates,
};
