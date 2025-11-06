// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_wallet_recharge_recharge_id_response.g.dart';

@JsonSerializable()
class UserWalletRechargeRechargeIdResponse {
  const UserWalletRechargeRechargeIdResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserWalletRechargeRechargeIdResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserWalletRechargeRechargeIdResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 充值结果
  final String message;

  /// 充值信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserWalletRechargeRechargeIdResponseToJson(this);
}
