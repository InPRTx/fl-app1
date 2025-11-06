// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultShop _$ResultShopFromJson(Map<String, dynamic> json) => ResultShop(
  id: (json['id'] as num).toInt(),
  shopName: json['shop_name'] as String,
  moneyAmount: json['money_amount'] as String,
  isEnable: json['is_enable'] as bool,
  isCannotNewPurchase: json['is_cannot_new_purchase'] as bool,
  humanReadText: json['human_read_text'] as String? ?? '',
);

Map<String, dynamic> _$ResultShopToJson(ResultShop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_name': instance.shopName,
      'money_amount': instance.moneyAmount,
      'human_read_text': instance.humanReadText,
      'is_enable': instance.isEnable,
      'is_cannot_new_purchase': instance.isCannotNewPurchase,
    };
