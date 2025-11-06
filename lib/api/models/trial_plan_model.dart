// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'trial_plan_features_model.dart';

part 'trial_plan_model.g.dart';

@JsonSerializable()
class TrialPlanModel {
  const TrialPlanModel({
    required this.planShopId,
    this.info,
    this.name = '新用户试用（与11元套餐完全一样）',
    this.price = '免费',
    this.currency = '¥',
    this.billing = '一次性',
    this.features = const [],
  });

  factory TrialPlanModel.fromJson(Map<String, Object?> json) =>
      _$TrialPlanModelFromJson(json);

  final String name;
  @JsonKey(includeIfNull: false)
  final String? info;
  final String price;
  final String currency;
  final String billing;

  /// 试用计划特性
  final List<TrialPlanFeaturesModel> features;

  /// 试用计划商品id
  @JsonKey(name: 'plan_shop_id')
  final Map<String, int> planShopId;

  Map<String, Object?> toJson() => _$TrialPlanModelToJson(this);
}
