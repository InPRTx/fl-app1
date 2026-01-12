// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'consume_verify_token_model.g.dart';

/// 消费验证令牌响应模型
@JsonSerializable()
class ConsumeVerifyTokenModel {
  const ConsumeVerifyTokenModel({
    required this.message,
    this.isSuccess = false,
  });

  factory ConsumeVerifyTokenModel.fromJson(Map<String, Object?> json) =>
      _$ConsumeVerifyTokenModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 消息提示
  final String message;

  Map<String, Object?> toJson() => _$ConsumeVerifyTokenModelToJson(this);
}
