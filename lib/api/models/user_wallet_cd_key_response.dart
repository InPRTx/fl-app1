// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_wallet_cd_key_response.g.dart';

@JsonSerializable()
class UserWalletCdKeyResponse {
  const UserWalletCdKeyResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserWalletCdKeyResponse.fromJson(Map<String, Object?> json) =>
      _$UserWalletCdKeyResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 激活码信息
  final dynamic result;

  Map<String, Object?> toJson() => _$UserWalletCdKeyResponseToJson(this);
}
