// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_shop_old_shop_id_confirm_order_response.g.dart';

@JsonSerializable()
class UserShopOldShopIdConfirmOrderResponse {
  const UserShopOldShopIdConfirmOrderResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserShopOldShopIdConfirmOrderResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserShopOldShopIdConfirmOrderResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 确认订单结果
  final String message;

  /// 订单信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserShopOldShopIdConfirmOrderResponseToJson(this);
}
