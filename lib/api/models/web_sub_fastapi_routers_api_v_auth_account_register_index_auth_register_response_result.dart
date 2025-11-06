// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_auth_account_register_index_auth_register_response_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult {
  const WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.userName,
    required this.email,
  });

  factory WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResultFromJson(
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

  /// 用户名
  @JsonKey(name: 'user_name')
  final String userName;

  /// 邮箱
  final String email;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResultToJson(
        this,
      );
}
