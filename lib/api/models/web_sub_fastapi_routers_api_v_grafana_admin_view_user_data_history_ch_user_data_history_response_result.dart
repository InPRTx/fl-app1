// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_grafana_admin_view_user_data_history_ch_user_data_history_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResult {
  const WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResult({
    required this.userId,
  });

  factory WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResultFromJson(
        json,
      );

  @JsonKey(name: 'user_id')
  final int userId;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResultToJson(
        this,
      );
}
