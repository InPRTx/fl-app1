// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'put_params_model.g.dart';

@JsonSerializable()
class PutParamsModel {
  const PutParamsModel({
    required this.shopId,
    required this.createdAt,
    required this.moneyAmount,
  });

  factory PutParamsModel.fromJson(Map<String, Object?> json) =>
      _$PutParamsModelFromJson(json);

  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'money_amount')
  final dynamic moneyAmount;

  Map<String, Object?> toJson() => _$PutParamsModelToJson(this);
}
