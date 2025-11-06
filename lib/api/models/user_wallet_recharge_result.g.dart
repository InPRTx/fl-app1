// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wallet_recharge_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletRechargeResult _$UserWalletRechargeResultFromJson(
  Map<String, dynamic> json,
) => UserWalletRechargeResult(
  result:
      WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserWalletRechargeResultToJson(
  UserWalletRechargeResult instance,
) => <String, dynamic>{'message': instance.message, 'result': instance.result};
