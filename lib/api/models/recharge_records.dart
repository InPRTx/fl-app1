// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'recharge_records.g.dart';

@JsonSerializable()
class RechargeRecords {
  const RechargeRecords({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tradeNo,
    required this.moneyAmount,
    required this.isFinish,
    required this.payMethodId,
    required this.invoiceId,
    required this.remark,
    required this.configJson,
  });

  factory RechargeRecords.fromJson(Map<String, Object?> json) =>
      _$RechargeRecordsFromJson(json);

  /// 支付记录ID
  final String id;

  /// 创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// 交易号
  @JsonKey(name: 'trade_no')
  final String tradeNo;

  /// 交易金额
  @JsonKey(name: 'money_amount')
  final String moneyAmount;

  /// 是否完成
  @JsonKey(name: 'is_finish')
  final bool isFinish;

  /// 支付方式ID
  @JsonKey(name: 'pay_method_id')
  final int payMethodId;

  /// 发票ID
  @JsonKey(includeIfNull: true, name: 'invoice_id')
  final String? invoiceId;

  /// 备注
  @JsonKey(includeIfNull: true)
  final String? remark;

  /// 配置JSON
  @JsonKey(name: 'config_json')
  final dynamic configJson;

  Map<String, Object?> toJson() => _$RechargeRecordsToJson(this);
}
