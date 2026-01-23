// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'result_list_data.g.dart';

@JsonSerializable()
class ResultListData {
  const ResultListData({
    required this.id,
    required this.createdAt,
    this.userName = '',
    this.email = '',
    this.moneyAmount = '0.00',
    this.isEnable = true,
  });

  factory ResultListData.fromJson(Map<String, Object?> json) =>
      _$ResultListDataFromJson(json);

  /// 用户ID
  final int id;

  /// 用户名
  @JsonKey(name: 'user_name')
  final String userName;

  /// 用户邮箱
  final String email;

  /// 用户余额
  @JsonKey(name: 'money_amount')
  final String moneyAmount;

  /// 注册时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 用户是否启用
  @JsonKey(name: 'is_enable')
  final bool isEnable;

  Map<String, Object?> toJson() => _$ResultListDataToJson(this);
}
