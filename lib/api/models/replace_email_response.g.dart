// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplaceEmailResponse _$ReplaceEmailResponseFromJson(
  Map<String, dynamic> json,
) => ReplaceEmailResponse(
  message: json['message'] as String,
  result:
      WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$ReplaceEmailResponseToJson(
  ReplaceEmailResponse instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
