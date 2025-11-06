// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_admin_api_replace_user_email_replace_email_response_result.dart';

part 'replace_email_response.g.dart';

@JsonSerializable()
class ReplaceEmailResponse {
  const ReplaceEmailResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory ReplaceEmailResponse.fromJson(Map<String, Object?> json) =>
      _$ReplaceEmailResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 替换结果
  final String message;

  /// 替换详情
  final WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult
  result;

  Map<String, Object?> toJson() => _$ReplaceEmailResponseToJson(this);
}
