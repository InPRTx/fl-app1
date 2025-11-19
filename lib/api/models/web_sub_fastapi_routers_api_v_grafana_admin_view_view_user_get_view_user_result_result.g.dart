// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_grafana_admin_view_view_user_get_view_user_result_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult
_$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult(
  userV2: AdminUserV.fromJson(json['user_v2'] as Map<String, dynamic>),
  oldService: AdminOldServiceOutput.fromJson(
    json['old_service'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResultToJson(
  WebSubFastapiRoutersApiVGrafanaAdminViewViewUserGetViewUserResultResult
  instance,
) => <String, dynamic>{
  'user_v2': instance.userV2,
  'old_service': instance.oldService,
};
