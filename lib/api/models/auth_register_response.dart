// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'web_sub_fastapi_routers_api_v_auth_account_register_index_auth_register_response_result.dart';

part 'auth_register_response.g.dart';

@JsonSerializable()
class AuthRegisterResponse {
  const AuthRegisterResponse({
    required this.message,
    required this.result,
    this.isSuccess = true,
  });

  factory AuthRegisterResponse.fromJson(Map<String, Object?> json) =>
      _$AuthRegisterResponseFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 注册结果
  final String message;

  /// 注册信息
  final WebSubFastapiRoutersApiVAuthAccountRegisterIndexAuthRegisterResponseResult
  result;

  Map<String, Object?> toJson() => _$AuthRegisterResponseToJson(this);
}
