// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'admin_old_service_output.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_old_service_get_user_old_service_response.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse {
  const WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse({
    this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponseFromJson(
        json,
      );

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 公告内容
  @JsonKey(includeIfNull: false)
  final AdminOldServiceOutput? result;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponseToJson(
        this,
      );
}
