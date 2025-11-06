// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_account_edit_email_response.g.dart';

@JsonSerializable()
class UserAccountEditEmailResponse {
  const UserAccountEditEmailResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserAccountEditEmailResponse.fromJson(Map<String, Object?> json) =>
      _$UserAccountEditEmailResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 编辑结果
  final String message;

  Map<String, Object?> toJson() => _$UserAccountEditEmailResponseToJson(this);
}
