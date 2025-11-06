// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_admin_api_replace_user_email_replace_email_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult {
  const WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult({
    required this.userId,
    required this.oldEmail,
    required this.newEmail,
    required this.updatedAt,
  });

  factory WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResultFromJson(
        json,
      );

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 原邮箱
  @JsonKey(name: 'old_email')
  final String oldEmail;

  /// 新邮箱
  @JsonKey(name: 'new_email')
  final String newEmail;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResultToJson(
        this,
      );
}
