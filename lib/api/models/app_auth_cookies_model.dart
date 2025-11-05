// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'app_auth_cookies_model.g.dart';

@JsonSerializable()
class AppAuthCookiesModel {
  const AppAuthCookiesModel({
    this.isLogin = false,
    this.isAdmin = false,
    this.uid,
    this.email,
    this.expireIn,
    this.ip,
    this.key,
  });

  factory AppAuthCookiesModel.fromJson(Map<String, Object?> json) =>
      _$AppAuthCookiesModelFromJson(json);

  @JsonKey(includeIfNull: false)
  final int? uid;
  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false, name: 'expire_in')
  final int? expireIn;
  @JsonKey(includeIfNull: false)
  final String? ip;
  @JsonKey(includeIfNull: false)
  final String? key;
  @JsonKey(name: 'is_login')
  final bool isLogin;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;

  Map<String, Object?> toJson() => _$AppAuthCookiesModelToJson(this);
}
