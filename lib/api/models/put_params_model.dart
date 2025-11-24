// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'put_params_model.g.dart';

@JsonSerializable()
class PutParamsModel {
  const PutParamsModel({
    required this.moneyAmount,
    required this.isFinish,
    required this.tradeNo,
    required this.payMethodId,
    required this.invoiceId,
    required this.remark,
  });

  factory PutParamsModel.fromJson(Map<String, Object?> json) =>
      _$PutParamsModelFromJson(json);

  @JsonKey(name: 'money_amount')
  final dynamic moneyAmount;
  @JsonKey(name: 'is_finish')
  final bool isFinish;
  @JsonKey(name: 'trade_no')
  final String tradeNo;
  @JsonKey(name: 'pay_method_id')
  final int payMethodId;
  @JsonKey(includeIfNull: true, name: 'invoice_id')
  final String? invoiceId;
  @JsonKey(includeIfNull: true)
  final String? remark;

  Map<String, Object?> toJson() => _$PutParamsModelToJson(this);
}
