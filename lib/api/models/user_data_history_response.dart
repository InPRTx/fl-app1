// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'user_data_history.dart';
import 'web_sub_fastapi_routers_api_v_grafana_admin_view_user_data_history_ch_user_data_history_response_result.dart';

part 'user_data_history_response.g.dart';

@JsonSerializable()
class UserDataHistoryResponse {
  const UserDataHistoryResponse({
    required this.resultList,
    this.isSuccess,
    this.message,
    this.result,
  });

  factory UserDataHistoryResponse.fromJson(Map<String, Object?> json) =>
      _$UserDataHistoryResponseFromJson(json);

  @JsonKey(includeIfNull: false, name: 'is_success')
  final bool? isSuccess;
  @JsonKey(includeIfNull: false)
  final String? message;
  @JsonKey(includeIfNull: false)
  final WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResult?
  result;
  @JsonKey(name: 'result_list')
  final List<UserDataHistory> resultList;

  Map<String, Object?> toJson() => _$UserDataHistoryResponseToJson(this);
}
