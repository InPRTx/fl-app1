// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'check_invite_code_params_model.g.dart';

@JsonSerializable()
class CheckInviteCodeParamsModel {
  const CheckInviteCodeParamsModel({
    this.inviteCode,
  });

  factory CheckInviteCodeParamsModel.fromJson(Map<String, Object?> json) =>
      _$CheckInviteCodeParamsModelFromJson(json);
  
  /// 邀请码
  @JsonKey(name: 'invite_code')
  final String? inviteCode;

  Map<String, Object?> toJson() => _$CheckInviteCodeParamsModelToJson(this);
}
