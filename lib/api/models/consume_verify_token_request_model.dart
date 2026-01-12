// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'consume_verify_token_request_model.g.dart';

/// 消费验证令牌请求模型
@JsonSerializable()
class ConsumeVerifyTokenRequestModel {
  const ConsumeVerifyTokenRequestModel({required this.verifyToken});

  factory ConsumeVerifyTokenRequestModel.fromJson(Map<String, Object?> json) =>
      _$ConsumeVerifyTokenRequestModelFromJson(json);

  /// 验证令牌（格式: cap_id:hash）
  @JsonKey(name: 'verify_token')
  final String verifyToken;

  Map<String, Object?> toJson() => _$ConsumeVerifyTokenRequestModelToJson(this);
}
