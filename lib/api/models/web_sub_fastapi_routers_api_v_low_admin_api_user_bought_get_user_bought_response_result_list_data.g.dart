// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_bought_get_user_bought_response_result_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
_$WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListDataFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: (json['user_id'] as num).toInt(),
      shopId: (json['shop_id'] as num).toInt(),
      shopName: json['shop_name'] as String,
      moneyAmount: json['money_amount'] as String,
      expireAt: json['expire_at'] == null
          ? null
          : DateTime.parse(json['expire_at'] as String),
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListDataToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
  instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'expire_at': ?instance.expireAt?.toIso8601String(),
  'user_id': instance.userId,
  'shop_id': instance.shopId,
  'shop_name': instance.shopName,
  'money_amount': instance.moneyAmount,
};
