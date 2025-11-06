// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shop_old_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShopOldResult _$UserShopOldResultFromJson(
  Map<String, dynamic> json,
) => UserShopOldResult(
  result:
      WebSubFastapiRoutersApiVUserShopOldIndexUserShopOldResultResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserShopOldResultToJson(UserShopOldResult instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'result': instance.result,
    };
