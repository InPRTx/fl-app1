// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_auth_jwt_token_login_old_v_params_model.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel {
  const WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel({
    this.accessToken,
    this.refreshToken,
  });

  factory WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModel.fromJson(
      Map<String, Object?> json) =>
      _$WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModelFromJson(json);
  
  /// 访问令牌
  @JsonKey(name: 'access_token')
  final String? accessToken;

  /// 刷新令牌
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAuthJwtTokenLoginOldVParamsModelToJson(this);
}
