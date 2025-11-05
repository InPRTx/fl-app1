// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_plan_features_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialPlanFeaturesModel _$TrialPlanFeaturesModelFromJson(
  Map<String, dynamic> json,
) => TrialPlanFeaturesModel(
  name: json['name'] as String,
  info: json['info'] as String?,
  support: json['support'] as bool? ?? true,
);

Map<String, dynamic> _$TrialPlanFeaturesModelToJson(
  TrialPlanFeaturesModel instance,
) => <String, dynamic>{
  'support': instance.support,
  'name': instance.name,
  'info': ?instance.info,
};
