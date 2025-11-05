// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'app_auth_cookies_model.dart';

part 'post_login_old_v_result_model.g.dart';

@JsonSerializable()
class PostLoginOldVResultModel {
  const PostLoginOldVResultModel({
    required this.result,
    this.isSuccess,
    this.message,
  });

  factory PostLoginOldVResultModel.fromJson(Map<String, Object?> json) =>
      _$PostLoginOldVResultModelFromJson(json);

  @JsonKey(includeIfNull: false, name: 'is_success')
  final bool? isSuccess;
  @JsonKey(includeIfNull: false)
  final String? message;
  final AppAuthCookiesModel result;

  Map<String, Object?> toJson() => _$PostLoginOldVResultModelToJson(this);
}
