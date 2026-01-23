// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'params_model.g.dart';

@JsonSerializable()
class ParamsModel {
  const ParamsModel({required this.refreshToken});

  factory ParamsModel.fromJson(Map<String, Object?> json) =>
      _$ParamsModelFromJson(json);

  /// 刷新令牌
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  Map<String, Object?> toJson() => _$ParamsModelToJson(this);
}
