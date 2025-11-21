// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop_old_shop_id_confirm_order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShopOldShopIdConfirmOrderResult
_$UserShopOldShopIdConfirmOrderResultFromJson(Map<String, dynamic> json) =>
    UserShopOldShopIdConfirmOrderResult(
      result: json['result'] == null
          ? null
          : OldServiceShopOutput.fromJson(
              json['result'] as Map<String, dynamic>,
            ),
      isSuccess: json['is_success'] as bool? ?? true,
      message: json['message'] as String? ?? '获取成功',
    );

Map<String, dynamic> _$UserShopOldShopIdConfirmOrderResultToJson(
  UserShopOldShopIdConfirmOrderResult instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': ?instance.result,
};
