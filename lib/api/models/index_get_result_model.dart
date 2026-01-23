// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'index_get_result_model.g.dart';

@JsonSerializable()
class IndexGetResultModel {
  const IndexGetResultModel({
    required this.result,
    this.isSuccess = true,
    this.message = '获取成功',
  });

  factory IndexGetResultModel.fromJson(Map<String, Object?> json) =>
      _$IndexGetResultModelFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 响应消息
  final String message;

  /// 用户令牌信息
  final Result result;

  Map<String, Object?> toJson() => _$IndexGetResultModelToJson(this);
}
