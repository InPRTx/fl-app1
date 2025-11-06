// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_services_link_token_reset_response.g.dart';

@JsonSerializable()
class UserServicesLinkTokenResetResponse {
  const UserServicesLinkTokenResetResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserServicesLinkTokenResetResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesLinkTokenResetResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 重置结果
  final String message;

  Map<String, Object?> toJson() =>
      _$UserServicesLinkTokenResetResponseToJson(this);
}
