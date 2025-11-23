// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'get_usernames_request.g.dart';

@JsonSerializable()
class GetUsernamesRequest {
  const GetUsernamesRequest({required this.userIds});

  factory GetUsernamesRequest.fromJson(Map<String, Object?> json) =>
      _$GetUsernamesRequestFromJson(json);

  /// 用户ID列表
  @JsonKey(name: 'user_ids')
  final List<int> userIds;

  Map<String, Object?> toJson() => _$GetUsernamesRequestToJson(this);
}
