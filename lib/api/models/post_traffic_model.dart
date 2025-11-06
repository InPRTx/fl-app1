// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'post_traffic_data_model.dart';

part 'post_traffic_model.g.dart';

@JsonSerializable()
class PostTrafficModel {
  const PostTrafficModel({required this.data});

  factory PostTrafficModel.fromJson(Map<String, Object?> json) =>
      _$PostTrafficModelFromJson(json);

  final List<PostTrafficDataModel> data;

  Map<String, Object?> toJson() => _$PostTrafficModelToJson(this);
}
