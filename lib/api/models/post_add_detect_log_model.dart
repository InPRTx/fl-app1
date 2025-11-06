// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'post_add_detect_log_data_model.dart';

part 'post_add_detect_log_model.g.dart';

@JsonSerializable()
class PostAddDetectLogModel {
  const PostAddDetectLogModel({required this.data});

  factory PostAddDetectLogModel.fromJson(Map<String, Object?> json) =>
      _$PostAddDetectLogModelFromJson(json);

  final List<PostAddDetectLogDataModel> data;

  Map<String, Object?> toJson() => _$PostAddDetectLogModelToJson(this);
}
