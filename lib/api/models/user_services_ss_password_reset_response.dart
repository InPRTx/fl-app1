// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_services_ss_password_reset_response.g.dart';

@JsonSerializable()
class UserServicesSsPasswordResetResponse {
  const UserServicesSsPasswordResetResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserServicesSsPasswordResetResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesSsPasswordResetResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 重置结果
  final String message;

  Map<String, Object?> toJson() =>
      _$UserServicesSsPasswordResetResponseToJson(this);
}
