// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_admin_api_announcement_announcement_update_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResult {
  const WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResult({
    required this.success,
  });

  factory WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResultFromJson(
        json,
      );

  final bool success;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResultToJson(
        this,
      );
}
