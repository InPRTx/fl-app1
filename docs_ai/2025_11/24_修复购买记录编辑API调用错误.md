# 修复购买记录编辑功能的 API 调用错误

## 问题描述

在运行时出现以下错误：

```
Error: The method 'WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel' isn't defined for the type '_BoughtRecordsListComponentState'.
```

以及后续的类型不匹配错误：

```
The argument type 'WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel' can't be assigned to the parameter type 'UserBought'.
```

## 问题原因

1. **缺少导出**：`WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel` 没有在 `api/export.dart` 中导出
2. **类型错误**：API 客户端 `putUserBoughtApiV2LowAdminApiUserBoughtBoughtIdPut` 实际期望的参数类型是 `UserBought`，而不是
   `WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel`

## 解决方案

### 1. 添加缺失的导出

在 `lib/api/export.dart` 中添加：

```dart
export 'models/web_sub_fastapi_routers_api_v_low_admin_api_user_bought_put_params_model.dart';
```

### 2. 修正 API 调用使用的类型

**修改前（错误）：**

```dart

final body = WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel(
  shopId: result['shopId'] as int,
  createdAt: (result['createdAt'] as DateTime).toUtc(),
  moneyAmount: result['moneyAmount'],
);
```

**修改后（正确）：**

```dart

final body = UserBought(
  userId: record.userId,
  shopId: result['shopId'] as int,
  createdAt: (result['createdAt'] as DateTime).toUtc(),
  moneyAmount: result['moneyAmount'],
);
```

### 关键差异

| 类型                                                            | 用途             | 字段                                                   |
|---------------------------------------------------------------|----------------|------------------------------------------------------|
| `WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel` | 可能是文档中的类型定义    | shopId, createdAt, moneyAmount                       |
| `UserBought`                                                  | API 客户端实际使用的类型 | **userId**, shopId, createdAt, moneyAmount, 以及其他可选字段 |

**重要**：`UserBought` 需要 `userId` 字段，而 `PutParamsModel` 不需要。

## 修改的文件

1. `/lib/api/export.dart` - 添加导出
2. `/lib/component/bought_records/bought_records_list_component.dart` - 修正 API 调用
3. `/lib/component/bought_records/bought_record_form_dialog.dart` - 修正备用组件

## API 客户端定义

```dart
@PUT('/api/v2/low_admin_api/user_bought/{bought_id}')
Future<ErrorResponse> putUserBoughtApiV2LowAdminApiUserBoughtBoughtIdPut({
  @Path('bought_id') required String boughtId,
  @Body() required UserBought body, // ← 注意这里使用 UserBought
});
```

## UserBought 类结构

```dart
class UserBought {
  const UserBought({
    required this.userId, // ← 必填
    required this.shopId, // ← 必填
    this.moneyAmount = 0.00,
    this.id,
    this.oldId,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.coupon,
  });

  final int userId;
  final int shopId;
  final dynamic moneyAmount;
  final DateTime? createdAt;
// ... 其他字段
}
```

## 验证

运行以下命令确保没有编译错误：

```bash
flutter clean
flutter pub get
flutter run
```

## 注意事项

1. ✅ 始终参考 `fallback_client.dart` 中的方法签名来确定正确的参数类型
2. ✅ 不要假设 `*PutParamsModel` 或 `*PostParamsModel` 就是正确的类型
3. ✅ API 自动生成的代码可能包含多个相似的类，要使用 API 客户端实际期望的类型
4. ⚠️ `UserBought` 需要 `userId` 字段，在编辑时要从原记录中获取

## 经验教训

在使用自动生成的 API 客户端时：

1. 首先检查 `fallback_client.dart` 中的方法定义
2. 确认方法签名中 `@Body()` 参数的实际类型
3. 使用该类型而不是假设的 `*ParamsModel` 类型
4. 如果类型没有导出，添加到 `api/export.dart` 中

