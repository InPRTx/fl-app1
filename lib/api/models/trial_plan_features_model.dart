// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'trial_plan_features_model.g.dart';

@JsonSerializable()
class TrialPlanFeaturesModel {
  const TrialPlanFeaturesModel({
    required this.name,
    this.info,
    this.support = true,
  });

  factory TrialPlanFeaturesModel.fromJson(Map<String, Object?> json) =>
      _$TrialPlanFeaturesModelFromJson(json);

  final bool support;
  final String name;
  @JsonKey(includeIfNull: false)
  final String? info;

  Map<String, Object?> toJson() => _$TrialPlanFeaturesModelToJson(this);
}
