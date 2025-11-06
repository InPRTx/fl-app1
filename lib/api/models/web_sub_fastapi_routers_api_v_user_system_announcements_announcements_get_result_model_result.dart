// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_system_announcements_announcements_get_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult {
  const WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult({
    required this.createdAt,
    required this.content,
  });

  factory WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResultFromJson(
        json,
      );

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String content;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResultToJson(
        this,
      );
}
