// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_wallet_purchase_records_old_purchase_records_result_result.dart';

part 'purchase_records_result.g.dart';

@JsonSerializable()
class PurchaseRecordsResult {
  const PurchaseRecordsResult({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory PurchaseRecordsResult.fromJson(Map<String, Object?> json) =>
      _$PurchaseRecordsResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;
  final String message;
  final List<
    WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult
  >
  result;

  Map<String, Object?> toJson() => _$PurchaseRecordsResultToJson(this);
}
