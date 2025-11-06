// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'body_delete_bought_v_user_bought_delete.g.dart';

@JsonSerializable()
class BodyDeleteBoughtVUserBoughtDelete {
  const BodyDeleteBoughtVUserBoughtDelete({required this.id});

  factory BodyDeleteBoughtVUserBoughtDelete.fromJson(
    Map<String, Object?> json,
  ) => _$BodyDeleteBoughtVUserBoughtDeleteFromJson(json);

  final int id;

  Map<String, Object?> toJson() =>
      _$BodyDeleteBoughtVUserBoughtDeleteToJson(this);
}
