// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_records_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseRecordsResult _$PurchaseRecordsResultFromJson(
  Map<String, dynamic> json,
) => PurchaseRecordsResult(
  message: json['message'] as String,
  result: (json['result'] as List<dynamic>)
      .map(
        (e) =>
            WebSubFastapiRoutersApiVUserWalletPurchaseRecordsOldPurchaseRecordsResultResult.fromJson(
              e as Map<String, dynamic>,
            ),
      )
      .toList(),
  isSuccess: json['is_success'] as bool? ?? true,
);

Map<String, dynamic> _$PurchaseRecordsResultToJson(
  PurchaseRecordsResult instance,
) => <String, dynamic>{
  'is_success': instance.isSuccess,
  'message': instance.message,
  'result': instance.result,
};
