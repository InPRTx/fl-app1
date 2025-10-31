// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_meta_data_announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemMetaDataAnnouncementModel _$SystemMetaDataAnnouncementModelFromJson(
  Map<String, dynamic> json,
) => SystemMetaDataAnnouncementModel(
  htmlText: json['html_text'] as String,
  markdownText: json['markdown_text'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$SystemMetaDataAnnouncementModelToJson(
  SystemMetaDataAnnouncementModel instance,
) => <String, dynamic>{
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'html_text': instance.htmlText,
  'markdown_text': instance.markdownText,
};
