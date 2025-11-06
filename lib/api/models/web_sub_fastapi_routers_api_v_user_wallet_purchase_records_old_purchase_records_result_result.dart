// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_wallet_purchase_records_old_purchase_records_result_result.g.dart';

/// 商品购买记录
@JsonSerializable()
class WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult {
  const WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult({
    required this.id,
    required this.createdAt,
    required this.shopId,
    required this.shopName,
    required this.moneyAmount,
    this.renewAt,
  });

  factory WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResultFromJson(
        json,
      );

  final String id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;
  @JsonKey(includeIfNull: false, name: 'renew_at')
  final DateTime? renewAt;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResultToJson(
        this,
      );
}
