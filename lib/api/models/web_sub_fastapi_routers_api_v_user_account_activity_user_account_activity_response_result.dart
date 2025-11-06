// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'activity_item.dart';

part 'web_sub_fastapi_routers_api_v_user_account_activity_user_account_activity_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult {
  const WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult({
    required this.totalCount,
    required this.activities,
  });

  factory WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResultFromJson(
        json,
      );

  /// 总活动数量
  @JsonKey(name: 'total_count')
  final int totalCount;

  /// 活动列表
  final List<ActivityItem> activities;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserAccountActivityUserAccountActivityResponseResultToJson(
        this,
      );
}
