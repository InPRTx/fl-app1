// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'admin_old_service.dart';
import 'admin_user_v.dart';

part 'web_sub_fastapi_routers_api_v_grafana_admin_view_view_user_get_view_user_result_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult {
  const WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult({
    required this.userV2,
    required this.oldService,
  });

  factory WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResultFromJson(
        json,
      );

  @JsonKey(name: 'user_v2')
  final AdminUserV userV2;
  @JsonKey(name: 'old_service')
  final AdminOldService oldService;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResultToJson(
        this,
      );
}
