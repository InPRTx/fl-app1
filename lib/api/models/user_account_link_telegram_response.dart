// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_link_telegram_response.g.dart';

@JsonSerializable()
class UserAccountLinkTelegramResponse {
  const UserAccountLinkTelegramResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserAccountLinkTelegramResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountLinkTelegramResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// Telegram 链接信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserAccountLinkTelegramResponseToJson(this);
}
