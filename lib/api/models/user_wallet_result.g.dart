// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wallet_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletResult _$UserWalletResultFromJson(
  Map<String, dynamic> json,
) => UserWalletResult(
  result:
      WebSubFastapiRoutersApiVUserWalletIndexUserWalletResultResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
  isSuccess: json['is_success'] as bool? ?? true,
  message: json['message'] as String? ?? '获取成功',
);

Map<String, dynamic> _$UserWalletResultToJson(UserWalletResult instance) =>
    <String, dynamic>{
      'is_success': instance.isSuccess,
      'message': instance.message,
      'result': instance.result,
    };
