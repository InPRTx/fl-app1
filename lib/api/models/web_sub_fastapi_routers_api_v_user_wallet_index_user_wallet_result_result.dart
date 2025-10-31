// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_wallet_index_user_wallet_result_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult {
  const WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult({
    required this.walletBalance,
    this.inviteBalance = '0.00',
    this.createdAt,
  });

  factory WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult.fromJson(
      Map<String, Object?> json) =>
      _$WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResultFromJson(
          json);
  
  /// 创建时间，查询的时间
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// 钱包余额
  @JsonKey(name: 'wallet_balance')
  final String walletBalance;

  /// 邀请余额
  @JsonKey(name: 'invite_balance')
  final String inviteBalance;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResultToJson(
          this);
}
