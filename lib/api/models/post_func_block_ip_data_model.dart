// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'post_func_block_ip_data_model.g.dart';

@JsonSerializable()
class PostFuncBlockIpDataModel {
  const PostFuncBlockIpDataModel({required this.ip});

  factory PostFuncBlockIpDataModel.fromJson(Map<String, Object?> json) =>
      _$PostFuncBlockIpDataModelFromJson(json);

  final String ip;

  Map<String, Object?> toJson() => _$PostFuncBlockIpDataModelToJson(this);
}
