// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_index_index_get_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult {
  const WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult({
    required this.userId,
    required this.accessType,
    required this.tokenType,
    required this.issuedAt,
    required this.expiresAt,
  });

  factory WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResult.fromJson(
    Map<String, Object?> json,
  ) => _$WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResultFromJson(
    json,
  );

  /// 用户ID
  @JsonKey(name: 'user_id')
  final int userId;

  /// 访问类型
  @JsonKey(name: 'access_type')
  final String accessType;

  /// 令牌类型
  @JsonKey(name: 'token_type')
  final String tokenType;

  /// 签发时间戳
  @JsonKey(name: 'issued_at')
  final int issuedAt;

  /// 过期时间戳
  @JsonKey(name: 'expires_at')
  final int expiresAt;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserIndexIndexGetResultModelResultToJson(this);
}
