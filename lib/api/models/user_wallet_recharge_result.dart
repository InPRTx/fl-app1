// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_wallet_recharge_index_user_wallet_recharge_result_result.dart';

part 'user_wallet_recharge_result.g.dart';

@JsonSerializable()
class UserWalletRechargeResult {
  const UserWalletRechargeResult({required this.result, this.message = '获取成功'});

  factory UserWalletRechargeResult.fromJson(Map<String, Object?> json) =>
      _$UserWalletRechargeResultFromJson(json);

  /// 响应消息
  final String message;

  /// 用户充值信息
  final WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult
  result;

  Map<String, Object?> toJson() => _$UserWalletRechargeResultToJson(this);
}
