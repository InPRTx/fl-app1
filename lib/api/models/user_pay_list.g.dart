// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pay_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPayList _$UserPayListFromJson(Map<String, dynamic> json) => UserPayList(
  userId: (json['user_id'] as num).toInt(),
  moneyAmount: json['money_amount'] as String,
  tradeNo: json['trade_no'] as String,
  isFinish: json['is_finish'] as bool? ?? true,
  payMethodId: (json['pay_method_id'] as num?)?.toInt() ?? 1,
  id: json['id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  configJson: json['config_json'],
  invoiceId: json['invoice_id'] as String?,
  remark: json['remark'] as String?,
);

Map<String, dynamic> _$UserPayListToJson(UserPayList instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'user_id': instance.userId,
      'money_amount': instance.moneyAmount,
      'is_finish': instance.isFinish,
      'trade_no': instance.tradeNo,
      'pay_method_id': instance.payMethodId,
      'config_json': ?instance.configJson,
      'invoice_id': ?instance.invoiceId,
      'remark': ?instance.remark,
    };
