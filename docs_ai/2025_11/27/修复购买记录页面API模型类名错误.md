# 修复购买记录页面API模型类名错误

## 日期

2025年11月27日

## 修改文件

- `/lib/page/low_admin/user_bought_list/low_admin_user_bought_list_page.dart`
- `/lib/component/bought_records/bought_records_list_component.dart`

## 问题描述

Hot reload 时出现编译错误，提示 `UserBought` 方法未定义：

```
Error: The method 'UserBought' isn't defined for the type '_AddBoughtRecordDialogState'.
Error: The method 'UserBought' isn't defined for the type '_BoughtRecordsListComponentState'.
```

## 根本原因

代码中错误地将 API 模型类当作方法调用，使用了不存在的 `UserBought()` 构造函数。

正确的类名应该是 `UserBoughtPydantic`，这是 API 自动生成的模型类。

## 修复方案

### 1. 修复添加购买记录（low_admin_user_bought_list_page.dart）

#### 修复前（错误）

```dart

final body = UserBought(
  userId: int.parse(_userIdController.text),
  shopId: int.parse(_shopIdController.text),
  createdAt: _createdAt.toUtc(),
  moneyAmount: _moneyAmountController.text,
);
```

#### 修复后（正确）

```dart

final body = UserBoughtPydantic(
  userId: int.parse(_userIdController.text),
  shopId: int.parse(_shopIdController.text),
  createdAt: _createdAt.toUtc(),
  moneyAmount: _moneyAmountController.text,
);
```

### 2. 修复编辑购买记录（bought_records_list_component.dart）

#### 修复前（错误）

```dart

final body = UserBought(
  userId: record.userId,
  shopId: result['shopId'] as int,
  createdAt: (result['createdAt'] as DateTime).toUtc(),
  moneyAmount: result['moneyAmount'],
);
```

#### 修复后（正确）

```dart
final body = UserBoughtPydantic(
  userId: record.userId,
  shopId: result['shopId'] as int,
  createdAt: (result['createdAt'] as DateTime).toUtc(),
  moneyAmount: result['moneyAmount'],
);
```

## API 模型详情

### UserBoughtPydantic 类定义

位于：`/lib/api/models/user_bought_pydantic.dart`

```dart
@JsonSerializable()
class UserBoughtPydantic {
  const UserBoughtPydantic({
    required this.userId,
    required this.shopId,
    required this.moneyAmount,
    this.id,
    this.oldId,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.coupon,
  });

  factory UserBoughtPydantic.fromJson(Map<String, Object?> json) =>
      _$UserBoughtPydanticFromJson(json);

  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(includeIfNull: false, name: 'old_id')
  final int? oldId;
  @JsonKey(includeIfNull: false, name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(includeIfNull: false, name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(includeIfNull: false, name: 'expires_at')
  final DateTime? expiresAt;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'shop_id')
  final int shopId;
  @JsonKey(includeIfNull: false)
  final String? coupon;
  @JsonKey(name: 'money_amount')
  final dynamic moneyAmount;

  Map<String, Object?> toJson() => _$UserBoughtPydanticToJson(this);
}
```

### 必需字段

- `userId`: 用户ID（整数）
- `shopId`: 商品ID（整数）
- `moneyAmount`: 金额（动态类型，可以是字符串或数字）

### 可选字段

- `id`: 记录ID（字符串）
- `oldId`: 旧ID（整数）
- `createdAt`: 创建时间（DateTime，UTC）
- `updatedAt`: 更新时间（DateTime，UTC）
- `expiresAt`: 过期时间（DateTime，UTC）
- `coupon`: 优惠券代码（字符串）

## 验证结果

### 编译检查

```bash
flutter analyze
```

**结果：** ✅ No errors found!

### Hot Reload

代码修复后可以正常进行 Hot Reload。

## 涉及的 API 端点

### POST /api/v2/low_admin_api/user_bought

创建新的购买记录

- 请求体：`UserBoughtPydantic`
- 响应：`ErrorResponse`

### PUT /api/v2/low_admin_api/user_bought/{bought_id}

更新购买记录

- 路径参数：`boughtId`（记录ID）
- 请求体：`UserBoughtPydantic`
- 响应：`ErrorResponse`

## 常见错误模式

### ❌ 错误：将类名当作方法

```dart

final body = UserBought(...); // UserBought 不存在
```

### ✅ 正确：使用完整的 Pydantic 类名

```dart

final body = UserBoughtPydantic(...); // 正确的类名
```

## 最佳实践

### 1. 检查 API 模型文件

当遇到类名错误时，首先检查 `/lib/api/models/` 目录中的实际类定义：

```bash
# 搜索购买记录相关的模型
grep -r "class.*Bought" lib/api/models/

# 结果示例
lib/api/models/user_bought_pydantic.dart:class UserBoughtPydantic {
```

### 2. 使用 IDE 自动补全

在 IDE 中输入类名时，使用自动补全功能可以避免拼写错误：

- 输入 `UserB...` 然后查看建议
- 选择正确的 `UserBoughtPydantic`

### 3. 遵循命名规范

API 自动生成的类通常遵循以下命名规范：

- **Pydantic 模型**：`{ModelName}Pydantic`
- **输入模型**：`{ModelName}Input`
- **输出模型**：`{ModelName}Output`
- **参数模型**：`{Path}ParamsModel`

### 4. 不要修改自动生成的代码

`/lib/api/models/` 目录下的文件都是自动生成的，不应手动修改。如果类名不符合预期，应该更新 OpenAPI 定义后重新生成。

## 时间处理规范（已遵循）

代码中正确地处理了时间：

```dart
// ✅ 提交到 API 时转换为 UTC
createdAt: _createdAt.toUtc
(),createdAt: (
result['createdAt'] as DateTime).toUtc(
)
,
```

符合项目的时间处理规范：

- **UI 使用本地时间**
- **API 使用 UTC 时间**

## 相关文档

- [修复节点管理页面API模型类名](./27_修复节点管理页面API模型类名.md)

## 总结

修复了两处 API 模型类名错误，将 `UserBought` 改为正确的 `UserBoughtPydantic`。这是 API 代码生成后常见的错误，需要注意使用自动生成的完整类名。

