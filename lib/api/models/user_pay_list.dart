// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_pay_list.g.dart';

@JsonSerializable()
class UserPayList {
  const UserPayList({
    required this.userId,
    required this.moneyAmount,
    required this.tradeNo,
    this.isFinish = true,
    this.payMethodId = 1,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.configJson,
    this.invoiceId,
    this.remark,
  });

  factory UserPayList.fromJson(Map<String, Object?> json) =>
      _$UserPayListFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;
  @JsonKey(name: 'is_finish')
  final bool isFinish;
  @JsonKey(name: 'trade_no')
  final String tradeNo;
  @JsonKey(name: 'pay_method_id')
  final int payMethodId;
  @JsonKey(includeIfNull: false, name: 'config_json')
  final dynamic configJson;
  @JsonKey(includeIfNull: false, name: 'invoice_id')
  final String? invoiceId;
  @JsonKey(includeIfNull: false)
  final String? remark;

  Map<String, Object?> toJson() => _$UserPayListToJson(this);
}
