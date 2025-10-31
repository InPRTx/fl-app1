// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'recharge_records.dart';

part 'web_sub_fastapi_routers_api_v_user_wallet_recharge_index_user_wallet_recharge_result_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult {
  const WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult({
    required this.rechargeRecords,
    this.createdAt,
  });

  factory WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResult.fromJson(
      Map<String, Object?> json) =>
      _$WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResultFromJson(
          json);
  
  /// 创建时间，查询的时间
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// 最近交易记录
  @JsonKey(name: 'recharge_records')
  final List<RechargeRecords> rechargeRecords;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserWalletRechargeIndexUserWalletRechargeResultResultToJson(
          this);
}
