// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'fastapi_compat_v_body_delete_bought_v_user_bought_delete.g.dart';

@JsonSerializable()
class FastapiCompatVBodyDeleteBoughtVUserBoughtDelete {
  const FastapiCompatVBodyDeleteBoughtVUserBoughtDelete({required this.id});

  factory FastapiCompatVBodyDeleteBoughtVUserBoughtDelete.fromJson(
    Map<String, Object?> json,
  ) => _$FastapiCompatVBodyDeleteBoughtVUserBoughtDeleteFromJson(json);

  final int id;

  Map<String, Object?> toJson() =>
      _$FastapiCompatVBodyDeleteBoughtVUserBoughtDeleteToJson(this);
}
