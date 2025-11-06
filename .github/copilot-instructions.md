尽量不要使用try来包装无意义的报错，
代码最大化用最精简的方法来实现功能
不要修改项目的/lib/api下的所有代码，该目录下的代码均为自动生成代码
在调用api类似使用下面

```dart
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_auth_account_login_index_params_model.dart';

final body = WebSubFastapiRoutersApiVAuthAccountLoginIndexParamsModel(
  email: _emailController.text.trim(),
  password: _passwordController.text,
  captchaKey: _fixedCaptchaKey,
  tiago2CapToken: _captchaToken!,
  isRememberMe: _rememberMe,
  twoFaCode: _twoFaController.text.isEmpty
      ? null
      : _twoFaController.text.trim(),
);
```

以下代码调用是最大扣分项

```dart
response = await
dio.get
('/test?id=12&name=dio
'
);
```

请把生成的文档放在
/docs_ai/年_月/日_操作.md 下面
月/日为01 02 10 这种两位长度

api url路径 /api/v2/low_admin_api 和 /api/v2/user 必须要带上访问令牌，不然会报401错误
所有api调用均使用model参数，避免手动构造query string
全局状态使用单例模式，确保状态一致性

## DateTime 时间处理规范

### 核心原则

API 使用 **UTC 时间**，UI 显示使用 **本地时间**

### 时间转换规则

#### 1. 从 API 获取数据（导入）

```dart
// API 模型自动解析为 DateTime（UTC时间）
// 在初始化时转换为本地时间用于显示和编辑
_dateTimeValues['userLevelExpireIn'] = service.userLevelExpireIn.toLocal();
```

#### 2. 提交数据到 API（导出）

```dart
// 提交前必须转换为 UTC 时间
final body = ModelName(
  userLevelExpireIn: (data['userLevelExpireIn'] as DateTime).toUtc(),
  userAccountExpireIn: (data['userAccountExpireIn'] as DateTime).toUtc(),
);
```

#### 3. UI 显示时间

```dart
// 显示前转换为本地时间并格式化
String _formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return 'N/A';
  final localDateTime = dateTime.toLocal();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
}
```

#### 4. 时间选择器

```dart
// 时间选择器使用本地时间，使用中文 locale
final pickedDate = await
showDatePicker
(
context: context,
initialDate: currentDate, // 已经是本地时间
firstDate: DateTime(2020),
lastDate: DateTime(2100),
locale: const Locale('zh', '
CN
'
)
, // 中文显示
);
```

### 完整示例

```dart
// 1. 初始化阶段：从 API 模型转换为本地时间
void _initializeControllers() {
  // API 返回的是 UTC 时间，转换为本地时间供编辑使用
  _dateTimeValues['userLevelExpireIn'] = service.userLevelExpireIn.toLocal();
  _dateTimeValues['userAccountExpireIn'] = userInfo.userAccountExpireIn.toLocal();
}

// 2. 提交阶段：从本地时间转换为 UTC 时间
Future<void> _toggleEdit() async {
  if (_isEditing) {
    final data = <String, dynamic>{
      // 其他字段...
      'userLevelExpireIn': _dateTimeValues['userLevelExpireIn']!,  // 本地时间
    };
    
    // 在 onUpdate 回调中转换为 UTC
    final body = ModelName(
      userLevelExpireIn: (data['userLevelExpireIn'] as DateTime).toUtc(),
    );
  }
}

// 3. 显示阶段：格式化本地时间
Widget _buildDateTimeInfoRow(String field, String label, DateTime value) {
  return _isEditing
      ? InkWell(
          onTap: () => _selectDateTime(field),
          child: Text(_formatDateTime(_dateTimeValues[field])),  // 显示本地时间
        )
      : Text(
          _formatDateTime(value),
          style: TextStyle(
            color: value.isBefore(DateTime.now()) ? Colors.red : Colors.green,
          ),
        );
}
```

### 关键点总结

1. ✅ API 数据模型使用 `DateTime.parse()` 自动解析为 UTC
2. ✅ API 数据模型使用 `toIso8601String()` 自动序列化为 UTC
3. ✅ 初始化时：API DateTime（UTC） → `.toLocal()` → UI 本地时间
4. ✅ 提交时：UI 本地时间 → `.toUtc()` → API DateTime（UTC）
5. ✅ 显示时：DateTime → `.toLocal()` → 格式化字符串
6. ✅ 时间选择器：使用本地时间 + 中文 locale
7. ✅ 比较时间：使用 `DateTime.now()` 会自动使用本地时间

### 错误示例 ❌

```dart
// 错误：直接使用 API 的 UTC 时间初始化编辑器
_dateTimeValues['
userLevelExpireIn
'
]
=
service.userLevelExpireIn; // ❌ 不转换

// 错误：提交时不转换为 UTC
userLevelExpireIn: data['
userLevelExpireIn
'
]

as DateTime, // ❌ 少了 .toUtc()

// 错误：显示时不转换为本地时间
    Text
(
dateTime
.
toString
(
)
); // ❌ 直接显示 UTC 时间
```
