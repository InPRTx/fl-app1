// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'admin_user_money_model.g.dart';

@JsonSerializable()
class AdminUserMoneyModel {
  const AdminUserMoneyModel({
    required this.id,
    required this.moneyAmount,
    this.moneyAmountRef = '0.00',
    this.inviteNum = 0,
  });

  factory AdminUserMoneyModel.fromJson(Map<String, Object?> json) =>
      _$AdminUserMoneyModelFromJson(json);

  final int id;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;
  @JsonKey(name: 'money_amount_ref')
  final String moneyAmountRef;
  @JsonKey(name: 'invite_num')
  final int inviteNum;

  Map<String, Object?> toJson() => _$AdminUserMoneyModelToJson(this);
}
