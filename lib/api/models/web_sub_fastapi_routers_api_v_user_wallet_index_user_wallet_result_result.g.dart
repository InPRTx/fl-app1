// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_wallet_index_user_wallet_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult
_$WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult(
  walletBalance: json['wallet_balance'] as String,
  inviteBalance: json['invite_balance'] as String? ?? '0.00',
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResultToJson(
  WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult instance,
) => <String, dynamic>{
  'created_at': ?instance.createdAt?.toIso8601String(),
  'wallet_balance': instance.walletBalance,
  'invite_balance': instance.inviteBalance,
};
