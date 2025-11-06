// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'get_version_model.g.dart';

@JsonSerializable()
class GetVersionModel {
  const GetVersionModel({required this.version});

  factory GetVersionModel.fromJson(Map<String, Object?> json) =>
      _$GetVersionModelFromJson(json);

  final String version;

  Map<String, Object?> toJson() => _$GetVersionModelToJson(this);
}
