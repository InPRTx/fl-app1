// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_admin_api_announcement_announcement_update_response_result.dart';

part 'announcement_update_response.g.dart';

@JsonSerializable()
class AnnouncementUpdateResponse {
  const AnnouncementUpdateResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory AnnouncementUpdateResponse.fromJson(Map<String, Object?> json) =>
      _$AnnouncementUpdateResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 更新结果
  final String message;

  /// 更新状态
  final WebSubFastapiRoutersApiVAdminApiAnnouncementAnnouncementUpdateResponseResult
  result;

  Map<String, Object?> toJson() => _$AnnouncementUpdateResponseToJson(this);
}
