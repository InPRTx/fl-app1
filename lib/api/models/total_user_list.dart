// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'total_user_list.g.dart';

@JsonSerializable()
class TotalUserList {
  const TotalUserList({required this.dataStartAts});

  factory TotalUserList.fromJson(Map<String, Object?> json) =>
      _$TotalUserListFromJson(json);

  @JsonKey(name: 'data_start_ats')
  final List<DateTime> dataStartAts;

  Map<String, Object?> toJson() => _$TotalUserListToJson(this);
}
