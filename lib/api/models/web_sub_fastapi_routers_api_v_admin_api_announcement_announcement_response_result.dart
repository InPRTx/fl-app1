// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_admin_api_announcement_announcement_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult {
  const WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult({
    required this.announcementId,
    required this.functionName,
    required this.markdownText,
    required this.htmlText,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResultFromJson(
        json,
      );

  /// 公告ID
  @JsonKey(name: 'announcement_id')
  final int announcementId;

  /// 功能名称
  @JsonKey(name: 'function_name')
  final String functionName;

  /// Markdown格式文本
  @JsonKey(name: 'markdown_text')
  final String markdownText;

  /// HTML格式文本
  @JsonKey(name: 'html_text')
  final String htmlText;

  /// 创建时间
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// 更新时间
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResultToJson(
        this,
      );
}
