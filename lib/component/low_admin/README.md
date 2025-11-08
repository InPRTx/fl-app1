# 用户信息和服务信息组件使用指南

## 组件概述

本目录包含两个主要的可编辑卡片组件：

1. **EditableUserV2InfoCardComponent** - 用户基本信息卡片
2. **EditableUserOldServiceCardComponent** - 旧版服务信息卡片

## 快速开始

### 1. 用户基本信息卡片

显示和编辑用户的基本信息，如邮箱、用户名、账号状态等。

```dart
import 'package:fl_app1/component/low_admin/editable_user_v2_info_card_component.dart';

EditableUserV2InfoCardComponent
(
userData: adminUserV,
onUpdate: (data) async {
// 处理更新逻辑
final body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPut(
email: data['email'] as String,
userName: data['userName'] as String,
isEnable: data['isEnable'] as bool,
isEmailVerify: data['isEmailVerify'] as bool,
userAccountExpireIn: (data['userAccountExpireIn'] as DateTime).toUtc(),
telegramId: data['telegramId'] as int?,
);

final result = await restClient.putUser(userId, body);
return result.isSuccess;
},
)
```

#### 可编辑字段

- 邮箱 (email)
- 用户名 (userName)
- Telegram ID (telegramId)
- 账号启用状态 (isEnable)
- 邮箱验证状态 (isEmailVerify)
- 账号过期时间 (userAccountExpireIn)

### 2. 旧版服务信息卡片

显示和编辑用户的服务信息，特别是流量数据，支持人类可读格式与字节数的双向转换。

```dart
import 'package:fl_app1/component/low_admin/editable_user_old_service_card_component.dart';

EditableUserOldServiceCardComponent
(
serviceData: adminOldService,
onUpdate: (data) async {
// 处理更新逻辑（使用PATCH方法支持部分更新）
final body = WebSubFastapiRoutersApiVLowAdminApiUserOldServiceParamModelPatch(
ssUploadSize: data['ssUploadSize'] as int?,
ssDownloadSize: data['ssDownloadSize'] as int?,
ssBandwidthTotalSize: data['ssBandwidthTotalSize'] as int?,
ssBandwidthYesterdayUsedSize: data['ssBandwidthYesterdayUsedSize'] as int?,
);

final result = await restClient.patchUserOldService(userId, body);
return result.isSuccess;
},
)
```

#### 可编辑字段（流量字段）

- 上传流量 (ssUploadSize)
- 下载流量 (ssDownloadSize)
- 总流量限制 (ssBandwidthTotalSize)
- 昨日使用流量 (ssBandwidthYesterdayUsedSize)

#### 只读字段

- 用户等级
- 等级过期时间
- 连接数量
- 速度限制
- 自动重置流量
- 自动重置日
- 最后使用时间
- 最后签到时间

## 流量编辑功能

### 特色功能：双格式转换

流量编辑对话框提供两个输入框：

1. **人类可读格式** - 例如 `10.5 GB`, `1024 MB`
2. **原始字节数** - 例如 `11274289152`

两个输入框会**实时同步转换**，修改任意一个，另一个会自动更新。

### 支持的单位

- B (Bytes)
- KB (Kilobytes)
- MB (Megabytes)
- GB (Gigabytes)
- TB (Terabytes)
- PB (Petabytes)

### 使用示例

在流量编辑对话框中：

- 输入 `10.5 GB` → 自动转换为 `11274289152` bytes
- 输入 `11274289152` → 自动转换为 `10.50 GB`

## 流量格式化工具

在 `lib/helper/format_helper.dart` 中提供了两个核心函数：

### formatBytes

将字节数格式化为人类可读格式。

```dart
import 'package:fl_app1/helper/format_helper.dart';

final humanReadable = formatBytes(1073741824);
// 输出: "1.00 GB"
```

### parseBytes

将人类可读格式解析为字节数。

```dart
import 'package:fl_app1/helper/format_helper.dart';

final bytes = parseBytes('10.5 GB');
// 输出: 11274289152
```

## UI 设计特点

### 卡片布局

- 清晰的标题栏，带图标
- 分隔线区分不同部分
- 统一的图标+标签+值的行布局
- 响应式的颜色状态指示

### 颜色语义

- **绿色** - 正常、已启用、充足
- **红色** - 异常、已禁用、不足、过期
- **橙色** - 警告、未验证
- **蓝色** - 提示信息、自动功能
- **灰色** - 辅助信息

### 交互设计

- **点击编辑按钮** - 进入编辑模式
- **点击流量行** - 弹出编辑对话框
- **点击时间字段** - 打开日期时间选择器
- **保存时** - 显示加载状态
- **操作完成** - SnackBar 反馈

## 时间处理规范

### 核心原则

- **API 使用 UTC 时间**
- **UI 显示使用本地时间**

### 转换流程

```dart
// 初始化时：从API获取的UTC时间转为本地时间
final localTime = apiDateTime.toLocal();

// 提交时：本地时间转为UTC时间
final utcTime = localDateTime.toUtc();

// 显示时：格式化本地时间
final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(localTime);
```

## 完整示例

查看 `lib/page/low_admin/user_detail/low_admin_user_detail_page.dart` 了解如何在实际页面中使用这些组件。

```dart
class _LowAdminUserDetailPageState extends State<LowAdminUserDetailPage> {
  AdminUserV? _userV2Data;
  AdminOldService? _userOldServiceData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          EditableUserV2InfoCardComponent(
            userData: _userV2Data,
            onUpdate: _updateUserV2,
          ),
          const SizedBox(height: 16),
          EditableUserOldServiceCardComponent(
            serviceData: _userOldServiceData,
            onUpdate: _updateUserOldService,
          ),
        ],
      ),
    );
  }
}
```

## 测试

运行单元测试：

```bash
# 测试流量格式化功能
flutter test test/format_helper_test.dart

# 运行所有测试
flutter test
```

## 注意事项

1. **onUpdate 回调必须返回 bool** - 表示更新是否成功
2. **时间字段必须转换** - 提交前转为UTC，显示前转为本地
3. **部分更新使用PATCH** - 流量字段编辑使用PATCH方法
4. **错误处理** - 在onUpdate中处理API错误，返回false
5. **状态刷新** - 更新成功后建议重新加载数据

## 相关文件

- 组件实现
    - `lib/component/low_admin/editable_user_v2_info_card_component.dart`
    - `lib/component/low_admin/editable_user_old_service_card_component.dart`
- 工具函数
    - `lib/helper/format_helper.dart`
- 使用示例
    - `lib/page/low_admin/user_detail/low_admin_user_detail_page.dart`
- 测试文件
    - `test/format_helper_test.dart`
- 文档
    - `docs_ai/2025_11/08_用户信息和服务信息界面重新设计.md`

