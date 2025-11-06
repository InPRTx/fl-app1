// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutParamsModel _$PutParamsModelFromJson(Map<String, dynamic> json) =>
    PutParamsModel(
      shopId: (json['shop_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      moneyAmount: json['money_amount'],
    );

Map<String, dynamic> _$PutParamsModelToJson(PutParamsModel instance) =>
    <String, dynamic>{
      'shop_id': instance.shopId,
      'created_at': instance.createdAt.toIso8601String(),
      'money_amount': instance.moneyAmount,
    };
