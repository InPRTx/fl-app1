// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bought.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBought _$UserBoughtFromJson(Map<String, dynamic> json) => UserBought(
  userId: (json['user_id'] as num).toInt(),
  shopId: (json['shop_id'] as num).toInt(),
  moneyAmount: json['money_amount'] ?? 0.00,
  id: json['id'] as String?,
  oldId: (json['old_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
  coupon: json['coupon'] as String?,
);

Map<String, dynamic> _$UserBoughtToJson(UserBought instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'old_id': ?instance.oldId,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'expires_at': ?instance.expiresAt?.toIso8601String(),
      'user_id': instance.userId,
      'shop_id': instance.shopId,
      'coupon': ?instance.coupon,
      'money_amount': instance.moneyAmount,
    };
