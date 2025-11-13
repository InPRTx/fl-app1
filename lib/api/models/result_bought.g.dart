// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_bought.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultBought _$ResultBoughtFromJson(Map<String, dynamic> json) => ResultBought(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  shopId: (json['shop_id'] as num).toInt(),
  shopName: json['shop_name'] as String,
  moneyAmount: json['money_amount'] as String,
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic> _$ResultBoughtToJson(ResultBought instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'expires_at': ?instance.expiresAt?.toIso8601String(),
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'money_amount': instance.moneyAmount,
    };
