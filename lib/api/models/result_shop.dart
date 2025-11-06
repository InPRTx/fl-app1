// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'result_shop.g.dart';

@JsonSerializable()
class ResultShop {
  const ResultShop({
    required this.id,
    required this.shopName,
    required this.moneyAmount,
    required this.isEnable,
    required this.isCannotNewPurchase,
    this.humanReadText = '',
  });

  factory ResultShop.fromJson(Map<String, Object?> json) =>
      _$ResultShopFromJson(json);

  final int id;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;
  @JsonKey(name: 'human_read_text')
  final String humanReadText;
  @JsonKey(name: 'is_enable')
  final bool isEnable;
  @JsonKey(name: 'is_cannot_new_purchase')
  final bool isCannotNewPurchase;

  Map<String, Object?> toJson() => _$ResultShopToJson(this);
}
