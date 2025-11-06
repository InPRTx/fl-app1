// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_auth_jwt_token_access_refresh_params_model.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModel {
  const WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModel({
    required this.refreshToken,
  });

  factory WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModel.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModelFromJson(
    json,
  );

  /// 刷新令牌
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshParamsModelToJson(
        this,
      );
}
