// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wallet_recharge_recharge_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletRechargeRechargeIdResponse
_$UserWalletRechargeRechargeIdResponseFromJson(Map<String, dynamic> json) =>
    UserWalletRechargeRechargeIdResponse(
      message: json['message'] as String,
      result: json['result'],
      isSuccess: json['is_success'] as bool? ?? true,
    );

Map<String, dynamic> _$UserWalletRechargeRechargeIdResponseToJson(
  UserWalletRechargeRechargeIdResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
