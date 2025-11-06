// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_security_post_response.g.dart';

@JsonSerializable()
class UserAccountSecurityPostResponse {
  const UserAccountSecurityPostResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserAccountSecurityPostResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountSecurityPostResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 设置结果
  final String message;

  Map<String, Object?> toJson() =>
      _$UserAccountSecurityPostResponseToJson(this);
}
