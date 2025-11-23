// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  const UserInfo({required this.userName, this.email});

  factory UserInfo.fromJson(Map<String, Object?> json) =>
      _$UserInfoFromJson(json);

  /// 用户名
  @JsonKey(name: 'user_name')
  final String userName;

  /// 邮箱
  @JsonKey(includeIfNull: false)
  final String? email;

  Map<String, Object?> toJson() => _$UserInfoToJson(this);
}
