// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'version_response_model.g.dart';

@JsonSerializable()
class VersionResponseModel {
  const VersionResponseModel({required this.data});

  factory VersionResponseModel.fromJson(Map<String, Object?> json) =>
      _$VersionResponseModelFromJson(json);

  final String data;

  Map<String, Object?> toJson() => _$VersionResponseModelToJson(this);
}
