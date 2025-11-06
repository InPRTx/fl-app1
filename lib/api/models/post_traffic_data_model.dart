// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'post_traffic_data_model.g.dart';

@JsonSerializable()
class PostTrafficDataModel {
  const PostTrafficDataModel({
    required this.userId,
    required this.u,
    required this.d,
  });

  factory PostTrafficDataModel.fromJson(Map<String, Object?> json) =>
      _$PostTrafficDataModelFromJson(json);

  @JsonKey(name: 'user_id')
  final int userId;
  final int u;
  final int d;

  Map<String, Object?> toJson() => _$PostTrafficDataModelToJson(this);
}
