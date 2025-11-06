// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_sub_fastapi_routers_api_v_admin_api_replace_user_email_replace_email_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult
_$WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResultFromJson(
  Map<String, dynamic> json,
) => WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult(
  userId: (json['user_id'] as num).toInt(),
  oldEmail: json['old_email'] as String,
  newEmail: json['new_email'] as String,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic>
_$WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResultToJson(
  WebSubFastapiRoutersApiVAdminApiReplaceUserEmailReplaceEmailResponseResult
  instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'old_email': instance.oldEmail,
  'new_email': instance.newEmail,
  'updated_at': instance.updatedAt.toIso8601String(),
};
