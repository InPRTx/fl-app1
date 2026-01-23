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
    required this.userId,
    required this.shopId,
    required this.shopName,
    required this.moneyAmount,
    this.expireAt,
  });

  factory ResultListData.fromJson(Map<String, Object?> json) =>
      _$ResultListDataFromJson(json);

  final String id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(includeIfNull: false, name: 'expire_at')
  final DateTime? expireAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(name: 'shop_name')
  final String shopName;
  @JsonKey(name: 'money_amount')
  final String moneyAmount;

  Map<String, Object?> toJson() => _$ResultListDataToJson(this);
}
