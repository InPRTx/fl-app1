# 修复 low_admin API 认证问题

## 问题描述

在 `lib/pages/low_admin/user_v2.dart` 文件中，API 调用没有自动附带 Bearer token，导致认证失败。该页面手动创建了 `Dio` 和
`RestClient` 实例，但没有添加认证拦截器。

## 问题原因

原代码直接创建了未经认证的客户端：

```dart
class _UserV2PageState extends State<UserV2Page> {
  final Dio _dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));
  late final RestClient _restClient = RestClient(
    _dio,
    baseUrl: kDefaultBaseUrl,
  );
// ...
}
```

这样创建的 `Dio` 实例没有 `AuthInterceptor`，因此不会自动在请求头中添加 `Authorization: Bearer <token>`。

## 解决方案

使用项目中已有的 `createAuthenticatedClient()` 函数来创建带有认证拦截器的客户端，并使用生成的 API 方法和模型类，而不是手动调用
Dio。

### 修改内容

1. **添加必要的导入**
   ```dart
   import 'package:fl_app1/utils/auth/auth_export.dart';
   ```

2. **移除不需要的导入**
   ```dart
   // 移除
   import 'package:dio/dio.dart';
   import 'package:fl_app1/api/base_url.dart';
   ```

3. **修改客户端创建方式**
   ```dart
   class _UserV2PageState extends State<UserV2Page> {
     late final RestClient _restClient = createAuthenticatedClient();
     // 不需要手动创建 Dio 实例
   }
   ```

4. **使用生成的 API 方法和模型类**

   ❌ **错误的做法**（手动拼接 URL 和 JSON）：
   ```dart
   final Map<String, dynamic> body = {};
   body['email'] = value as String;
   final response = await _dio.patch(
     '/api/v2/low_admin_api/user_v2/${widget.userId}',
     data: body,
   );
   ```

   ✅ **正确的做法**（使用生成的模型和方法）：
   ```dart
   final body = WebSubFastapiRoutersApiVLowAdminApiUserVParamModelPatch(
     email: value as String,
   );
   final response = await _restClient.fallback
       .patchUserV2ApiV2LowAdminApiUserV2UserIdPatch(
     userId: widget.userId,
     body: body,
   );
   ```

## 工作原理

`createAuthenticatedClient()` 函数（位于 `lib/utils/auth/authenticated_client.dart`）会：

1. 创建一个配置了正确 baseUrl 的 `Dio` 实例
2. 自动添加 `AuthInterceptor` 拦截器
3. 返回一个带有认证功能的 `RestClient` 实例

`AuthInterceptor` 会在每个请求发送前自动：

- 从 `AuthStore` 获取当前的 access token
- 将 token 添加到请求头：`Authorization: Bearer <token>`
- 输出调试信息，方便追踪认证状态

## 影响范围

- **文件**: `lib/pages/low_admin/user_v2.dart`
- **影响功能**:
    - 用户 V2 信息查询和更新
    - 用户旧服务信息查询和更新
    - 所有 low_admin API 调用

## 验证方法

1. 登录应用
2. 访问用户管理页面（User V2）
3. 查看控制台输出，应该显示：
   ```
   📤 API Request: GET /api/v2/low_admin_api/user_v2/{userId} [Auth: ✓]
   📤 API Request: GET /api/v2/low_admin_api/user_old_service/{userId} [Auth: ✓]
   ```
4. 编辑用户信息，确认更新成功
5. 查看网络请求，确认请求头中包含 `Authorization: Bearer ...`

## 最佳实践

在整个项目中，所有需要认证的 API 调用都应该：

1. **导入认证工具**
   ```dart
   import 'package:fl_app1/utils/auth/auth_export.dart';
   ```

2. **使用认证客户端**
   ```dart
   late final RestClient _restClient = createAuthenticatedClient();
   ```

3. **使用生成的 API 方法**
    - ✅ 使用 `_restClient.fallback.xxxApiMethod()`
    - ❌ 不要使用 `dio.get('/xxx')` 或 `dio.patch('/xxx')`

4. **使用生成的模型类**
    - ✅ 使用生成的 Param 模型类构造请求体
    - ❌ 不要使用 `Map<String, dynamic>` 手动构造 JSON

5. **避免手动创建 Dio 实例**
    - ❌ 不要 `final Dio _dio = Dio()`
    - ✅ 使用 `createAuthenticatedClient()` 统一管理

### 为什么要使用生成的 API 方法？

- **类型安全**：编译时就能发现参数错误
- **自动认证**：通过 `AuthInterceptor` 自动添加 Bearer token
- **代码简洁**：避免手动拼接 URL 和 JSON
- **易于维护**：API 变更时只需重新生成代码
- **符合规范**：遵循项目编码规范，避免最大扣分项

## 相关文件

- `lib/utils/auth/authenticated_client.dart` - 创建认证客户端的工厂函数
- `lib/utils/auth/auth_interceptor.dart` - 认证拦截器实现
- `lib/utils/auth/auth_store.dart` - Token 存储管理
- `lib/pages/low_admin/user_v2.dart` - 本次修改的文件

## 修改时间

2025年11月5日

