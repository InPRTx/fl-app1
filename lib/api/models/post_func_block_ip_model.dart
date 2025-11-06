// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'post_func_block_ip_data_model.dart';

part 'post_func_block_ip_model.g.dart';

@JsonSerializable()
class PostFuncBlockIpModel {
  const PostFuncBlockIpModel({required this.data});

  factory PostFuncBlockIpModel.fromJson(Map<String, Object?> json) =>
      _$PostFuncBlockIpModelFromJson(json);

  final List<PostFuncBlockIpDataModel> data;

  Map<String, Object?> toJson() => _$PostFuncBlockIpModelToJson(this);
}
