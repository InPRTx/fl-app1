# 修复用户详情页 API 模型类型错误

**日期**: 2025年11月19日  
**操作**: 修复编译错误

## 问题描述

在 `low_admin_user_detail_page.dart` 和 `editable_user_old_service_card_component.dart` 中使用了错误的 API 模型类型，导致编译错误：

1. 使用了不存在的类型 `AdminOldService`（应使用 `AdminOldServiceOutput`）
2. 使用了不存在的构造函数 `WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut`
3. 使用了不存在的构造函数 `WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut`
4. `AdminUserV` 构造函数缺少必填字段

## 修复内容

### 1. 修复 `low_admin_user_detail_page.dart`

#### 变量类型修正

```dart
// 修改前
AdminOldService? _userOldServiceData;

// 修改后
AdminOldServiceOutput? _userOldServiceData;
```

#### 用户信息更新方法修正（统一字段命名）

```dart
// 修改前 - 使用不一致的字段名
Future<bool> _updateUserV2(Map<String, dynamic> data) async {
  final body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut(
    email: data['email'] as String,
    userName: data['userName'] as String,
    isEnable: data['isEnable'] as bool,
    // ❌ 与模型不一致
    isEmailVerify: data['isEmailVerify'] as bool,
    userAccountExpireIn: (data['userAccountExpireIn'] as DateTime).toUtc(),
    telegramId: data['telegramId'] as int?, // ❌ 与模型不一致
  );
  // ...
}

// 修改后 - 使用与 AdminUserV 模型一致的字段名
Future<bool> _updateUserV2(Map<String, dynamic> data) async {
  if (_userV2Data == null) return false;

  final body = AdminUserV(
    id: _userV2Data!.id,
    createdAt: _userV2Data!.createdAt,
    email: data['email'] as String,
    userName: data['userName'] as String,
    isEnabled: data['isEnabled'] as bool,
    // ✅ 与模型字段一致
    isEmailVerify: data['isEmailVerify'] as bool,
    userAccountExpireIn: (data['userAccountExpireIn'] as DateTime).toUtc(),
    tgId: data['tgId'] as int?,
    // ✅ 与模型字段一致
    regIp: _userV2Data!.regIp,
  );
  // ...
}
```

**关键点**：

- 使用实际的 API 模型类 `AdminUserV`
- 提供所有必填字段：`id`、`createdAt`、`regIp` 从现有数据中获取
- **字段名统一映射**：`isEnable` → `isEnabled`，`telegramId` → `tgId`
- 确保数据传递链路的字段名完全一致

#### 旧服务信息更新方法修正

```dart
// 修改前
Future<bool> _updateUserOldService(Map<String, dynamic> data) async {
  final body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPut(
    // ...
  );
  // ...
}

// 修改后
Future<bool> _updateUserOldService(Map<String, dynamic> data) async {
  final body = AdminOldServiceInput(
    ssUploadSize: data['ssUploadSize'] as int,
    ssDownloadSize: data['ssDownloadSize'] as int,
    ssBandwidthTotalSize: data['ssBandwidthTotalSize'] as int,
    userLevelExpireIn: (data['userLevelExpireIn'] as DateTime).toUtc(),
    ssBandwidthYesterdayUsedSize:
    data['ssBandwidthYesterdayUsedSize'] as int? ?? 0,
    userLevel: data['userLevel'] as int? ?? 0,
    nodeConnector: data['nodeConnector'] as int?,
    autoResetDay: data['autoResetDay'] as int?,
    autoResetBandwidth: data['autoResetBandwidth'],
    nodeSpeedLimit: data['nodeSpeedLimit'],
    ssLastUsedTime: _userOldServiceData?.ssLastUsedTime,
    lastCheckInTime: _userOldServiceData?.lastCheckInTime,
  );
  // ...
}
```

**关键点**：

- 使用 `AdminOldServiceInput` 作为 PUT 请求的 body 类型
- API 返回使用 `AdminOldServiceOutput`，提交使用 `AdminOldServiceInput`

### 2. 修复 `editable_user_v2_info_card_component.dart`（字段名统一）

#### 移除重复导入并修正类型

```dart
// 修改前
import '../../api/models/admin_old_service.dart';

class EditableUserOldServiceCardComponent extends StatefulWidget {
  final AdminOldService? serviceData;
// ...
}

Widget _buildContent(AdminOldService service) {
  // ...
}

// 修改后
class EditableUserOldServiceCardComponent extends StatefulWidget {
  final AdminOldServiceOutput? serviceData;
// ...
}

Widget _buildContent(AdminOldServiceOutput service) {
  // ...
}
```

#### 组件内部字段名统一修改

为了确保整个数据流的字段名一致性，对组件内部的变量名也进行了统一修改：

```dart
// 修改前 - 与 API 模型不一致
late final TextEditingController _telegramIdController; // ❌
late bool _isEnable; // ❌

void _initializeControllers() {
  _telegramIdController.text = user?.tgId?.toString() ?? '';
  _isEnable = user?.isEnabled ?? true;
}

final data = {
  'isEnable': _isEnable, // ❌ 字段名不一致
  'telegramId': _telegramIdController.text... // ❌ 字段名不一致
};

// 修改后 - 与 API 模型完全一致
late final TextEditingController _tgIdController; // ✅
late bool _isEnabled; // ✅

void _initializeControllers() {
  _tgIdController.text = user?.tgId?.toString() ?? '';
  _isEnabled = user?.isEnabled ?? true;
}

final data = {
  'isEnabled': _isEnabled, // ✅ 字段名一致
  'tgId': _tgIdController.text... // ✅ 字段名一致
};
```

#### UI 更新

```dart
// TextField controller
TextField
(
controller: _tgIdController, // ✅ 统一使用 tgId
// ...
)

// SwitchListTile
SwitchListTile(
title: const Text('账号启用状态'),
subtitle: Text(_isEnabled ? '已启用' : '已禁用'), // ✅ 统一使用 isEnabled
value: _isEnabled,
onChanged: (value) => setState(() => _isEnabled = value),
)
```

**关键点**：

- 移除了多余的导入（`AdminOldServiceOutput` 已在 `api/export.dart` 中导出）
- 统一使用 `AdminOldServiceOutput` 类型
- **内部变量名与 API 模型字段名完全一致**，消除命名隐患
- 确保从 UI → 组件 → 页面 → API 的整个数据流字段名一致

### 3. 字段名统一对照表

| UI/组件变量名                    | Map Key          | AdminUserV 字段 | 说明     |
|-----------------------------|------------------|---------------|--------|
| `_isEnabled`                | `isEnabled`      | `isEnabled`   | ✅ 完全一致 |
| `_tgIdController`           | `tgId`           | `tgId`        | ✅ 完全一致 |
| ~~`_isEnable`~~             | ~~`isEnable`~~   | -             | ❌ 已移除  |
| ~~`_telegramIdController`~~ | ~~`telegramId`~~ | -             | ❌ 已移除  |

## API 模型类型说明

### AdminUserV

- **用途**: GET/PUT 用户基本信息
- **必填字段**: id, createdAt, email, userName, isEnabled, tgId, regIp, userAccountExpireIn
- **注意**: PUT 时必须提供所有必填字段（完全替换模式）

### AdminOldServiceOutput

- **用途**: GET 旧版服务信息（API 响应）
- **包含字段**: 流量使用、等级、限速等所有服务相关数据

### AdminOldServiceInput

- **用途**: PUT 旧版服务信息（API 请求）
- **包含字段**: 与 Output 相同，但用于提交数据
- **差异**: `autoResetBandwidth` 类型为 `double`（Input）vs `String`（Output）

## 代码规范遵守

✅ 使用正确的 API 模型类型  
✅ 所有变量明确类型声明  
✅ 遵循 DateTime UTC/Local 转换规范  
✅ 不修改 `/lib/api` 自动生成代码  
✅ 使用 Model 参数调用 API  
✅ **字段名在整个数据流中保持一致**（UI → 组件 → 页面 → API）  
✅ 消除命名隐患，避免运行时字段映射错误

## 修复亮点

### 🎯 字段名一致性保证

通过统一修改组件和页面中的所有字段名，确保：

1. **类型安全**：编译时检查字段存在性
2. **可维护性**：字段名与 API 模型定义完全一致
3. **无隐患**：消除了 `isEnable`/`isEnabled`、`telegramId`/`tgId` 的混用

### 📊 数据流完整性

```
用户输入 (_isEnabled, _tgIdController)
    ↓
Map<String, dynamic> {'isEnabled': ..., 'tgId': ...}
    ↓
AdminUserV(isEnabled: ..., tgId: ...)
    ↓
API 请求
```

整个链路字段名完全一致，不存在中间转换或映射错误的风险。

## 测试验证

编译验证通过，无错误和警告。

## 相关文件

- `/lib/page/low_admin/user_detail/low_admin_user_detail_page.dart` (已修改)
- `/lib/component/low_admin/editable_user_v2_info_card_component.dart` (已修改)
- `/lib/component/low_admin/editable_user_old_service_card_component.dart` (已修改)
- `/lib/api/models/admin_user_v.dart` (自动生成)
- `/lib/api/models/admin_old_service_output.dart` (自动生成)
- `/lib/api/models/admin_old_service_input.dart` (自动生成)

