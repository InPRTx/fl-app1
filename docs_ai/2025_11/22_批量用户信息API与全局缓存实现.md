# 新增批量用户信息 API 与全局缓存实现

日期：2025-11-22

## 新增 API: /api/v2/low_admin_api/user_v2/batch_user_infos

### 目的

- 批量获取用户的 user_name 与 email，用于在列表/详情页显示用户名与头像（使用 Gravatar）。

### 服务实现位置

- **文件**：`lib/store/service/user/user_service.dart`
- **单例**：UserService
- **主要方法**：
    - `fetchBatchUserInfos(List<int> userIds)` → `Future<Map<int, UserInfo>>`
        - 使用已认证的 RestClient（createAuthenticatedClient）调用生成代码：
          `getBatchUserInfosApiV2LowAdminApiUserV2BatchUserInfosPost`
        - 返回一个以 int userId 为键的 Map，对无法解析为 int 的键会忽略
        - **使用全局 UserStore 缓存**：缓存存储在 `lib/store/user_store.dart`（单例 ChangeNotifier）
        - **并行批量请求**：缺失的 userIds 按 batchSize (200) 分块，使用 `Future.wait` 并行请求，提升性能
    - **缓存管理 API**：
        - `clearCache()` — 清空全部缓存
        - `evict(int userId)` — 移除单个用户缓存
    - **测试注入**：提供 `setRestClientForTest(RestClient)` 用于单元测试 mock

### 全局用户信息缓存 (UserStore)

- **文件**：`lib/store/user_store.dart`
- **导出**：`lib/store/index.dart`
- **单例 ChangeNotifier**，提供：
    - `getUserInfo(int userId)` — 读取单个用户信息
    - `putAll(Map<int, UserInfo>)` — 批量写入并通知监听者
    - `evict(int userId)` — 移除指定用户
    - `clear()` — 清空缓存
- 可在多个页面共享用户信息缓存，避免重复请求

### 注意事项

- `/api/v2/low_admin_api` 路径需要带访问令牌（由 createAuthenticatedClient 提供），否则会返回 401
- 所有 API 调用均使用 model 参数，避免手动构造 query string
- 并行请求默认每批 200 个 ID，可根据需求调整 `_batchSize` 常量
- 缓存在全局单例中，应用生命周期内保持（除非手动 clear/evict）

### Gravatar 头像说明

- 使用用户邮箱计算 Gravatar URL；如果邮箱为空则不返回头像 URL。
- **计算规则**：
    1. 规范化邮箱：trim() 并转为小写
    2. 计算 MD5（hex）摘要
    3. 构造 URL：`https://www.gravatar.com/avatar/<md5>?s=<size>&d=identicon`
- **示例**：
  ```dart
  final avatar = UserService().gravatarUrlForEmail(user.email, size: 80);
  ```

### 示例调用

```dart

final userIds = <int>[1, 2, 3];
final users = await
UserService
().

fetchBatchUserInfos(userIds);

final user1 = users[1];
final displayName = user1?.userName ?? '已销号';
final avatar = UserService().gravatarUrlForEmail(user1?.email, size: 80);
```

### UI 集成示例（工单详情页）

```dart
// 在 _loadTicketDetail() 成功后调用
final Set<int> ids = <int>{};
ids.add
(
_ticket!.userId);
final messages = _ticket!.messages ?? [];
for (final m in messages) {
ids.add(m.userId);
}

try {
final fetched = await UserService().fetchBatchUserInfos(ids.toList());
if (!mounted) return;
setState(() {
_userInfos = fetched;
});
} catch (_) {
// 不做无意义的报错包装，页面仍然可以显示基础信息
}

// 显示用户名和 Gravatar
final ownerInfo = _userInfos[_ticket!.userId];
final ownerAvatar = UserService().gravatarUrlForEmail(ownerInfo?.email, size: 40);
final ownerName = ownerInfo?.userName ?? '用户ID: ${_ticket!.userId}';

CircleAvatar(
radius: 20,
backgroundColor: Colors.grey[200],
backgroundImage: ownerAvatar != null ? NetworkImage(ownerAvatar) : null,
child: ownerAvatar == null ? Icon(Icons.person, color: Colors.grey
[
700
]
)
:
null
,
)
```

### 单元测试

- **测试文件**：`test/user_service_test.dart`
- **测试覆盖**：
    - 批量获取并缓存用户信息
    - 第二次调用使用缓存（无网络请求）
    - clearCache 清空所有缓存
    - evict 移除单个用户缓存
    - gravatarUrlForEmail 正确生成 URL
    - gravatarUrlForEmail 处理空值和规范化
    - 处理 API 返回的非 int 键
- **运行测试**：`flutter test test/user_service_test.dart`
- **测试结果**：✅ **All 8 tests passed**

### 建议

- 对大量 userIds 时可分批请求（**已实现**：每批 200，并行执行），避免请求体过大或服务端限流。
- 可在 UI 层缓存已获取的用户信息（**已实现**：全局 UserStore 缓存），减少重复请求。
- 如需清理缓存（例如用户登出），调用 `UserService().clearCache()` 或 `UserStore().clear()`。
- 可通过监听 UserStore (ChangeNotifier) 在 UI 中响应缓存更新（例如使用 Provider 或 ValueListenableBuilder）。

## 已完成任务清单

- [x] 
    1. 实现并行批量请求（Future.wait，默认每批200个ID）
- [x] 
    2. 添加缓存管理 API（clearCache、evict）
- [x] 
    3. 将缓存提升为全局 store（UserStore，单例 ChangeNotifier）
- [x] 
    4. 添加单元测试（8个测试用例，全部通过）
- [x] 
    5. 在工单详情页集成 UserService 显示用户名和 Gravatar
- [x] 
    6. 更新文档说明实现细节与使用方法

