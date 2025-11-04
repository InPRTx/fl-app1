# 认证系统快速使用指南

## 快速开始

### 1. 导入认证存储

```dart
import 'package:fl_app1/utils/auth/auth_store.dart';
```

### 2. 获取实例（单例）

```dart

final authStore = AuthStore();
```

## 常用操作

### 登录后保存 Token

```dart
// 在登录 API 成功后
await
authStore.setTokens
(
response.result.accessToken,
response.result.refreshToken,
);
```

### 检查登录状态

```dart
if (authStore.isAuthenticated) {
print('用户已登录');
print('邮箱: ${authStore.userEmail}');
} else {
print('用户未登录');
}
```

### 获取 Token

```dart

String? accessToken = authStore.accessToken;
String? refreshToken = authStore.refreshToken;
```

### 登出

```dart
await
authStore.logout
();
```

### 在 Widget 中监听状态变化

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final AuthStore authStore = AuthStore();

  @override
  void initState() {
    super.initState();
    authStore.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    authStore.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    setState(() {
      // UI 会在认证状态变化时重建
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        authStore.isAuthenticated ? '已登录' : '未登录'
    );
  }
}
```

### 创建带认证的 API 请求

```dart
import 'package:fl_app1/utils/auth/authenticated_client.dart';

final client = createAuthenticatedClient();
final response = await
client.fallback.yourApiMethod
();
```

## 特性

- ✅ **自动刷新**: Token 在过期前 60 秒自动刷新
- ✅ **安全存储**: Refresh token 加密存储
- ✅ **状态监听**: 支持 ChangeNotifier 监听
- ✅ **单例模式**: 全局统一状态
- ✅ **自动初始化**: 应用启动时自动加载 token

## 存储位置

- **Access Token**: SharedPreferences (类似前端的 sessionStorage)
- **Refresh Token**: FlutterSecureStorage (加密存储)
- **Token 过期时间**: SharedPreferences (ISO8601 格式)

## 自动功能

应用启动时会自动：

1. 从存储加载 tokens
2. 如果有 refresh token 但没有 access token，自动刷新
3. 设置自动刷新定时器

## 注意事项

1. **不要手动清除 SharedPreferences/FlutterSecureStorage**，使用 `logout()` 方法
2. **AuthStore 是单例**，`AuthStore()` 总是返回同一个实例
3. **Token 会自动刷新**，不需要手动处理刷新逻辑
4. **监听器需要在 dispose 时移除**，防止内存泄漏

## 调试

查看控制台日志了解 token 刷新情况：

- "将在 X 秒后刷新访问令牌"
- "开始刷新访问令牌..."
- "访问令牌刷新成功"
- "Token refresh failed: ..."

