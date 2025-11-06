// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'post_add_detect_log_data_model.g.dart';

@JsonSerializable()
class PostAddDetectLogDataModel {
  const PostAddDetectLogDataModel({required this.userId, required this.listId});

  factory PostAddDetectLogDataModel.fromJson(Map<String, Object?> json) =>
      _$PostAddDetectLogDataModelFromJson(json);

  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'list_id')
  final int listId;

  Map<String, Object?> toJson() => _$PostAddDetectLogDataModelToJson(this);
}
