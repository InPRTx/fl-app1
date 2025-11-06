// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_wallet_cd_key_cd_key_response.g.dart';

@JsonSerializable()
class UserWalletCdKeyCdKeyResponse {
  const UserWalletCdKeyCdKeyResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserWalletCdKeyCdKeyResponse.fromJson(Map<String, Object?> json) =>
      _$UserWalletCdKeyCdKeyResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 激活结果
  final String message;

  /// 激活信息
  final dynamic result;

  Map<String, Object?> toJson() => _$UserWalletCdKeyCdKeyResponseToJson(this);
}
