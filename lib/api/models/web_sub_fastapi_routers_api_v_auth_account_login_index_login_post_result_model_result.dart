// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_auth_account_login_index_login_post_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult {
  const WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });

  factory WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResultFromJson(
        json,
      );

  /// 访问令牌
  @JsonKey(name: 'access_token')
  final String accessToken;

  /// 刷新令牌
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAuthAccountLoginIndexLoginPostResultModelResultToJson(
        this,
      );
}
