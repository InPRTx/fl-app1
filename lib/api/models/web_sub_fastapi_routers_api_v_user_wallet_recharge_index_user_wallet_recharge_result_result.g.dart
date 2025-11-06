// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_wallet_recharge_index_user_wallet_recharge_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult
_$WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult(
      rechargeRecords: (json['recharge_records'] as List<dynamic>)
          .map((e) => RechargeRecords.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResultToJson(
  WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult
  instance,
) => <String, dynamic>{
  'created_at': ?instance.createdAt?.toIso8601String(),
  'recharge_records': instance.rechargeRecords,
};
