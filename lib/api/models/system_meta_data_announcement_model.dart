// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'system_meta_data_announcement_model.g.dart';

@JsonSerializable()
class SystemMetaDataAnnouncementModel {
  const SystemMetaDataAnnouncementModel({
    required this.htmlText,
    required this.markdownText,
    this.createdAt,
    this.updatedAt,
  });

  factory SystemMetaDataAnnouncementModel.fromJson(Map<String, Object?> json) =>
      _$SystemMetaDataAnnouncementModelFromJson(json);

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'html_text')
  final String htmlText;
  @JsonKey(name: 'markdown_text')
  final String markdownText;

  Map<String, Object?> toJson() =>
      _$SystemMetaDataAnnouncementModelToJson(this);
}
