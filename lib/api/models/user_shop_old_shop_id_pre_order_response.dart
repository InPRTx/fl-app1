// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_shop_old_shop_id_pre_order_response.g.dart';

@JsonSerializable()
class UserShopOldShopIdPreOrderResponse {
  const UserShopOldShopIdPreOrderResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserShopOldShopIdPreOrderResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserShopOldShopIdPreOrderResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 预订结果
  final String message;

  /// 预订信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserShopOldShopIdPreOrderResponseToJson(this);
}
