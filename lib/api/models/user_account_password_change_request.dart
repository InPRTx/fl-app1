// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_password_change_request.g.dart';

@JsonSerializable()
class UserAccountPasswordChangeRequest {
  const UserAccountPasswordChangeRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  factory UserAccountPasswordChangeRequest.fromJson(
    Map<String, Object?> json,
  ) => _$UserAccountPasswordChangeRequestFromJson(json);

  /// 当前密码
  @JsonKey(name: 'current_password')
  final String currentPassword;

  /// 新密码
  @JsonKey(name: 'new_password')
  final String newPassword;

  Map<String, Object?> toJson() =>
      _$UserAccountPasswordChangeRequestToJson(this);
}
