// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserMoney _$AdminUserMoneyFromJson(Map<String, dynamic> json) =>
    AdminUserMoney(
      id: (json['id'] as num).toInt(),
      moneyAmount: json['money_amount'] as String,
      moneyAmountRef: json['money_amount_ref'] as String? ?? '0.00',
      inviteNum: (json['invite_num'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AdminUserMoneyToJson(AdminUserMoney instance) =>
    <String, dynamic>{
      'id': instance.id,
      'money_amount': instance.moneyAmount,
      'money_amount_ref': instance.moneyAmountRef,
      'invite_num': instance.inviteNum,
    };
