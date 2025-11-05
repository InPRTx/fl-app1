// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_auth_jwt_token_access_refresh_refresh_post_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult {
  const WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult({
    required this.accessToken,
    required this.userId,
    this.refreshToken,
  });

  factory WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResultFromJson(
        json,
      );

  /// 访问令牌
  @JsonKey(name: 'access_token')
  final String accessToken;

  /// 刷新令牌，将在到期1天内进行回复
  @JsonKey(includeIfNull: false, name: 'refresh_token')
  final String? refreshToken;

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAuthJwtTokenAccessRefreshRefreshPostResultModelResultToJson(
        this,
      );
}
