// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'total_node_list.g.dart';

@JsonSerializable()
class TotalNodeList {
  const TotalNodeList({required this.dataStartAts});

  factory TotalNodeList.fromJson(Map<String, Object?> json) =>
      _$TotalNodeListFromJson(json);

  @JsonKey(name: 'data_start_ats')
  final List<DateTime> dataStartAts;

  Map<String, Object?> toJson() => _$TotalNodeListToJson(this);
}
