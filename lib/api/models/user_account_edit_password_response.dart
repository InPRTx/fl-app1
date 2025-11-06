// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_edit_password_response.g.dart';

@JsonSerializable()
class UserAccountEditPasswordResponse {
  const UserAccountEditPasswordResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserAccountEditPasswordResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountEditPasswordResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 编辑结果
  final String message;

  Map<String, Object?> toJson() =>
      _$UserAccountEditPasswordResponseToJson(this);
}
