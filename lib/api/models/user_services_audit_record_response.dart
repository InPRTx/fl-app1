// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_services_audit_record_response.g.dart';

@JsonSerializable()
class UserServicesAuditRecordResponse {
  const UserServicesAuditRecordResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory UserServicesAuditRecordResponse.fromJson(Map<String, Object?> json) =>
      _$UserServicesAuditRecordResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 审计记录信息
  final dynamic result;

  Map<String, Object?> toJson() =>
      _$UserServicesAuditRecordResponseToJson(this);
}
