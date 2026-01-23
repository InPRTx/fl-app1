// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'user_wallet_result.g.dart';

@JsonSerializable()
class UserWalletResult {
  const UserWalletResult({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory UserWalletResult.fromJson(Map<String, Object?> json) =>
      _$UserWalletResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户钱包信息
  final Result result;

  Map<String, Object?> toJson() => _$UserWalletResultToJson(this);
}
