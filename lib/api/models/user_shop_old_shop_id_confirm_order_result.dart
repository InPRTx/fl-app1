// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'old_service_shop.dart';

part 'user_shop_old_shop_id_confirm_order_result.g.dart';

@JsonSerializable()
class UserShopOldShopIdConfirmOrderResult {
  const UserShopOldShopIdConfirmOrderResult({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserShopOldShopIdConfirmOrderResult.fromJson(
    Map<String, Object?> json,
  ) => _$UserShopOldShopIdConfirmOrderResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 确认订单结果
  final String message;

  /// 订单信息
  @JsonKey(includeIfNull: false)
  final OldServiceShop? result;

  Map<String, Object?> toJson() =>
      _$UserShopOldShopIdConfirmOrderResultToJson(this);
}
