// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataHistoryResponse _$UserDataHistoryResponseFromJson(
  Map<String, dynamic> json,
) => UserDataHistoryResponse(
  resultList: (json['result_list'] as List<dynamic>)
      .map((e) => UserDataHistory.fromJson(e as Map<String, dynamic>))
      .toList(),
  isSuccess: json['is_success'] as bool?,
  message: json['message'] as String?,
  result: json['result'] == null
      ? null
      : WebSubFastapiRoutersApiVGrafanaAdminViewUserDataHistoryChUserDataHistoryResponseResult.fromJson(
          json['result'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserDataHistoryResponseToJson(
  UserDataHistoryResponse instance,
) => <String, dynamic>{
  'is_success': ?instance.isSuccess,
  'message': ?instance.message,
  'result': ?instance.result,
  'result_list': instance.resultList,
};
