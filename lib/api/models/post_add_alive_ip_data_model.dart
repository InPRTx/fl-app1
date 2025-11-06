// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'post_add_alive_ip_data_model.g.dart';

@JsonSerializable()
class PostAddAliveIpDataModel {
  const PostAddAliveIpDataModel({required this.userId, required this.ip});

  factory PostAddAliveIpDataModel.fromJson(Map<String, Object?> json) =>
      _$PostAddAliveIpDataModelFromJson(json);

  @JsonKey(name: 'user_id')
  final int userId;
  final String ip;

  Map<String, Object?> toJson() => _$PostAddAliveIpDataModelToJson(this);
}
