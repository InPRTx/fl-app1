// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

import 'result_list_data.dart';

part 'web_sub_fastapi_routers_api_v_low_admin_api_user_bought_get_user_bought_response.g.dart';

@JsonSerializable()
class WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse {
  const WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse({
    this.isSuccess = true,
    this.message = '获取成功',
    this.resultList = const [],
  });

  factory WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponse.fromJson(
    Map<String, Object?> json,
  ) =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseFromJson(
        json,
      );

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  /// 获取结果
  final String message;

  /// 管理员用户信息
  @JsonKey(name: 'result_list')
  final List<ResultListData> resultList;

  Map<String, Object?> toJson() =>
      _$WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseToJson(
        this,
      );
}
