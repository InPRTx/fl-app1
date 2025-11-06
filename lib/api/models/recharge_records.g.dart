// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recharge_records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RechargeRecords _$RechargeRecordsFromJson(Map<String, dynamic> json) =>
    RechargeRecords(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      tradeNo: json['trade_no'] as String,
      moneyAmount: json['money_amount'] as String,
      isFinish: json['is_finish'] as bool,
      payMethodId: (json['pay_method_id'] as num).toInt(),
      invoiceId: json['invoice_id'] as String?,
      remark: json['remark'] as String?,
      configJson: json['config_json'],
    );

Map<String, dynamic> _$RechargeRecordsToJson(RechargeRecords instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'trade_no': instance.tradeNo,
      'money_amount': instance.moneyAmount,
      'is_finish': instance.isFinish,
      'pay_method_id': instance.payMethodId,
      'invoice_id': instance.invoiceId,
      'remark': instance.remark,
      'config_json': instance.configJson,
    };
