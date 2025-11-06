// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialPlanModel _$TrialPlanModelFromJson(Map<String, dynamic> json) =>
    TrialPlanModel(
      planShopId: Map<String, int>.from(json['plan_shop_id'] as Map),
      info: json['info'] as String?,
      name: json['name'] as String? ?? '新用户试用（与11元套餐完全一样）',
      price: json['price'] as String? ?? '免费',
      currency: json['currency'] as String? ?? '¥',
      billing: json['billing'] as String? ?? '一次性',
      features:
          (json['features'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TrialPlanFeaturesModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TrialPlanModelToJson(TrialPlanModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'info': ?instance.info,
      'price': instance.price,
      'currency': instance.currency,
      'billing': instance.billing,
      'features': instance.features,
      'plan_shop_id': instance.planShopId,
    };
