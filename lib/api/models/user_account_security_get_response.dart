// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_security_get_response.g.dart';

@JsonSerializable()
class UserAccountSecurityGetResponse {
  const UserAccountSecurityGetResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserAccountSecurityGetResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountSecurityGetResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 安全设置信息
  final dynamic result;

  Map<String, Object?> toJson() => _$UserAccountSecurityGetResponseToJson(this);
}
