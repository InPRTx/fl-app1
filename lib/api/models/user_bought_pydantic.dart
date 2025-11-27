// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_bought_pydantic.g.dart';

@JsonSerializable()
class UserBoughtPydantic {
  const UserBoughtPydantic({
    required this.userId,
    required this.shopId,
    required this.moneyAmount,
    this.id,
    this.oldId,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.coupon,
  });

  factory UserBoughtPydantic.fromJson(Map<String, Object?> json) =>
      _$UserBoughtPydanticFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(includeIfNull: false, name: 'old_id')
  final int? oldId;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(includeIfNull: false, name: 'expires_at')
  final DateTime? expiresAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(includeIfNull: false)
  final String? coupon;
  @JsonKey(name: 'money_amount')
  final dynamic moneyAmount;

  Map<String, Object?> toJson() => _$UserBoughtPydanticToJson(this);
}
