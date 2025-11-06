// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_low_admin_api_user_bought_put_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel
_$WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModelFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel(
  shopId: (json['shop_id'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  moneyAmount: json['money_amount'],
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModelToJson(
  WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel instance,
) => <String, dynamic>{
  'shop_id': instance.shopId,
  'created_at': instance.createdAt.toIso8601String(),
  'money_amount': instance.moneyAmount,
};
