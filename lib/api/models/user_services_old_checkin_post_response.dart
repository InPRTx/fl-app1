// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_services_old_checkin_post_response.g.dart';

@JsonSerializable()
class UserServicesOldCheckinPostResponse {
  const UserServicesOldCheckinPostResponse({
    required this.message,
    this.isSuccess = true,
  });

  factory UserServicesOldCheckinPostResponse.fromJson(
    Map<String, Object?> json,
  ) => _$UserServicesOldCheckinPostResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 签到结果
  final String message;

  Map<String, Object?> toJson() =>
      _$UserServicesOldCheckinPostResponseToJson(this);
}
