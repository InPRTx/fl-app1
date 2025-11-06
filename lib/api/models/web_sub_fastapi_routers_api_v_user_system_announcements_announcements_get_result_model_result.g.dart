// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_user_system_announcements_announcements_get_result_model_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult
_$WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResultFromJson(
  Map<String, dynamic> json,
) =>
    WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult(
      createdAt: DateTime.parse(json['created_at'] as String),
      content: json['content'] as String,
    );

Map<String, dynamic>
_$WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResultToJson(
  WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult
  instance,
) => <String, dynamic>{
  'created_at': instance.createdAt.toIso8601String(),
  'content': instance.content,
};
