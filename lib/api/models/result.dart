// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  const Result({
    required this.walletBalance,
    this.inviteBalance = '0.00',
    this.createdAt,
  });

  factory Result.fromJson(Map<String, Object?> json) => _$ResultFromJson(json);

  /// 创建时间，查询的时间
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;

  /// 钱包余额
  @JsonKey(name: 'wallet_balance')
  final String walletBalance;

  /// 邀请余额
  @JsonKey(name: 'invite_balance')
  final String inviteBalance;

  Map<String, Object?> toJson() => _$ResultToJson(this);
}
