// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop_old_shop_id_pre_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShopOldShopIdPreOrderResponse _$UserShopOldShopIdPreOrderResponseFromJson(
  Map<String, dynamic> json,
) => UserShopOldShopIdPreOrderResponse(
  message: json['message'] as String,
  result: json['result'],
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$UserShopOldShopIdPreOrderResponseToJson(
  UserShopOldShopIdPreOrderResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
