// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultListData _$ResultListDataFromJson(Map<String, dynamic> json) =>
    ResultListData(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      userName: json['user_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      moneyAmount: json['money_amount'] as String? ?? '0.00',
      isEnable: json['is_enable'] as bool? ?? true,
    );

Map<String, dynamic> _$ResultListDataToJson(ResultListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'email': instance.email,
      'money_amount': instance.moneyAmount,
      'created_at': instance.createdAt.toIso8601String(),
      'is_enable': instance.isEnable,
    };
