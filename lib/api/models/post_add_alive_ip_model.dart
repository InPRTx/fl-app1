// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'post_add_alive_ip_data_model.dart';

part 'post_add_alive_ip_model.g.dart';

@JsonSerializable()
class PostAddAliveIpModel {
  const PostAddAliveIpModel({required this.data});

  factory PostAddAliveIpModel.fromJson(Map<String, Object?> json) =>
      _$PostAddAliveIpModelFromJson(json);

  final List<PostAddAliveIpDataModel> data;

  Map<String, Object?> toJson() => _$PostAddAliveIpModelToJson(this);
}
