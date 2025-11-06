// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_admin_api_announcement_announcement_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult
_$WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult(
  announcementId: (json['announcement_id'] as num).toInt(),
  functionName: json['function_name'] as String,
  markdownText: json['markdown_text'] as String,
  htmlText: json['html_text'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResultToJson(
  WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementResponseResult
  instance,
) => <String, dynamic>{
  'announcement_id': instance.announcementId,
  'function_name': instance.functionName,
  'markdown_text': instance.markdownText,
  'html_text': instance.htmlText,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
