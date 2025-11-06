// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'web_sub_fastapi_routers_api_v_user_crisp_data_crisp_data_result_model_result.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult {
  const WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult({
    required this.userEmail,
    required this.userNickname,
    required this.sessionData,
  });

  factory WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResult.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResultFromJson(
        json,
      );

  /// 用户邮箱
  @JsonKey(name: 'user_email')
  final String userEmail;

  /// 用户昵称
  @JsonKey(name: 'user_nickname')
  final String userNickname;

  /// 会话数据
  @JsonKey(name: 'session_data')
  final List<List<dynamic>> sessionData;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVUserCrispDataCrispDataResultModelResultToJson(
        this,
      );
}
