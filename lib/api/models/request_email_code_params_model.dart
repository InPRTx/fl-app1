// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'request_email_code_params_model.g.dart';

@JsonSerializable()
class RequestEmailCodeParamsModel {
  const RequestEmailCodeParamsModel({required this.verifyToken, this.email});

  factory RequestEmailCodeParamsModel.fromJson(Map<String, Object?> json) =>
      _$RequestEmailCodeParamsModelFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? email;

  /// POW验证令牌
  @JsonKey(name: 'verify_token')
  final String verifyToken;

  Map<String, Object?> toJson() => _$RequestEmailCodeParamsModelToJson(this);
}
