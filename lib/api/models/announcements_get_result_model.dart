// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_user_system_announcements_announcements_get_result_model_result.dart';

part 'announcements_get_result_model.g.dart';

@JsonSerializable()
class AnnouncementsGetResultModel {
  const AnnouncementsGetResultModel({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory AnnouncementsGetResultModel.fromJson(Map<String, Object?> json) =>
      _$AnnouncementsGetResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;
  final String message;
  final WebSubFastapiRoutersApiVUserSystemAnnouncementsAnnouncementsGetResultModelResult
  result;

  Map<String, Object?> toJson() => _$AnnouncementsGetResultModelToJson(this);
}
