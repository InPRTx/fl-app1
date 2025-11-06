// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'get_csrf_token_result.g.dart';

@JsonSerializable()
class GetCsrfTokenResult {
  const GetCsrfTokenResult({required this.csrfToken, this.isSuccess = true});

  factory GetCsrfTokenResult.fromJson(Map<String, Object?> json) =>
      _$GetCsrfTokenResultFromJson(json);

  @JsonKey(name: 'is_success')
  final bool isSuccess;
  @JsonKey(name: 'csrf_token')
  final String csrfToken;

  Map<String, Object?> toJson() => _$GetCsrfTokenResultToJson(this);
}
