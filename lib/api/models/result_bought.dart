// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'result_bought.g.dart';

@JsonSerializable()
class ResultBought {
  const ResultBought({
    required this.id,
    required this.createdAt,
    required this.shopId,
    required this.shopName,
    required this.moneyAmount,
    this.expireAt,
  });

  factory ResultBought.fromJson(Map<String, Object?> json) =>
      _$ResultBoughtFromJson(json);

  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(includeIfNull: false, name: 'expire_at')
  final DateTime? expireAt;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;

  Map<String, Object?> toJson() => _$ResultBoughtToJson(this);
}
