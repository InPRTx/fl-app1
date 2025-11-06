// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_wallet_purchase_records_old_purchase_records_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult
_$WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      shopId: (json['shop_id'] as num).toInt(),
      shopName: json['shop_name'] as String,
      moneyAmount: json['money_amount'] as String,
      renewAt: json['renew_at'] == null
          ? null
          : DateTime.parse(json['renew_at'] as String),
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResultToJson(
  WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult
  instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'shop_id': instance.shopId,
  'shop_name': instance.shopName,
  'money_amount': instance.moneyAmount,
  'renew_at': ?instance.renewAt?.toIso8601String(),
};
