// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop_old_shop_id_confirm_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShopOldShopIdConfirmOrderResponse
_$UserShopOldShopIdConfirmOrderResponseFromJson(Map<String, dynamic> json) =>
    UserShopOldShopIdConfirmOrderResponse(
      message: json['message'] as String,
      result: json['result'],
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserShopOldShopIdConfirmOrderResponseToJson(
  UserShopOldShopIdConfirmOrderResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
