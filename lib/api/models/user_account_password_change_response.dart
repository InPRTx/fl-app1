// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_password_change_response.g.dart';

@JsonSerializable()
class UserAccountPasswordChangeResponse {
  const UserAccountPasswordChangeResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserAccountPasswordChangeResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserAccountPasswordChangeResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 密码修改结果
  final String message;

  Map<String, Object?> toJson() =>
      _$UserAccountPasswordChangeResponseToJson(this);
}
