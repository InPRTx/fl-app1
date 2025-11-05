// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'admin_user_v.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_v_get_user_old_service_response.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse {
  const WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponseFromJson(
        json,
      );

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 管理员用户信息
  @JsonKey(includeIfNull: false)
  final AdminUserV? result;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponseToJson(
        this,
      );
}
