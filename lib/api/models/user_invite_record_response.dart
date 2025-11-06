// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_invite_record_response.g.dart';

@JsonSerializable()
class UserInviteRecordResponse {
  const UserInviteRecordResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserInviteRecordResponse.fromJson(Map<String, Object?> json) =>
      _$UserInviteRecordResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 邀请记录
  final dynamic result;

  Map<String, Object?> toJson() => _$UserInviteRecordResponseToJson(this);
}
