# 将管理员标识从 `is_admin` 迁移到 `role`（2025-11-06）

概述

- 目标：客户端不再依赖 `subject_access.is_admin`（该字段已被移除）。现在后端必须把管理员角色放在 JWT 的顶层 `role` 字段：
    - `malio_postgrest_admin`
    - `malio_postgrest_low_admin`
- 客户端改动：`AuthStore.isAdmin` 仅基于 token 的顶层 `role` 字段判断管理员身份，不再回退到 `subject_access.is_admin`。

变更内容（客户端）

- 修改文件：`/lib/utils/auth/auth_store.dart`
    - 新逻辑：当 `accessTokenPayload.role` 等于 `malio_postgrest_admin` 或 `malio_postgrest_low_admin` 时，视为管理员。
    - 已移除对 `subject_access.is_admin` 的兼容回退（server 已删除该字段）。

原因和兼容性

- 原因：后端统一使用 `role` 字段表示用户的 PostgREST 角色，避免重复字段。
- 兼容性：客户端现在假定后端已完成迁移；如果后端仍使用旧字段，请先和后端协调。

后端（必须）

- 必须在生成访问令牌（access token）时，将管理员角色放在顶层 `role` 声明：
    - 管理员：`"role": "malio_postgrest_admin"` 或 `"role": "malio_postgrest_low_admin"`
    - 普通用户示例：`"role": "malio_postgrest_user"`

服务端示例（伪代码）

- 在后端 JWT 生成逻辑中（Python/FastAPI/其他），示例：

```py
payload = {
    "jti": str(uuid4()),
    "exp": int(time.time()) + ACCESS_TOKEN_EXPIRES,
    "iat": int(time.time()),
    "role": "malio_postgrest_admin",  # 或 malio_postgrest_low_admin
    "subject_access": {
        "user_id": user.id,
        "email": user.email,
        # "is_admin": True  # 已删除，可省略
    },
    "token_type": "access"
}
```

测试和验证

1. 本地测试（客户端）
    - 使用 `test/token_test.dart` 中的示例 token 或使用后端生成的真实 token。确保解析后 `JWTTokenModel.role` 为
      `malio_postgrest_admin`。
2. UI 验证
    - 登录使用管理员 token，主页应显示 `前往管理主页` 按钮。
    - 登录普通用户 token，应隐藏该按钮。
3. 自动化
    - 若需要，可在服务端集成集成测试，验证生成的 token 中包含正确的 `role`，并对受保护路由进行访问校验。

注意事项

- 前端显示权限只是 UX 层面保护：所有管理端点仍应在后端做权限验证。
- 本次变更假定后端已经删除 `subject_access.is_admin`，客户端已移除兼容代码。

文件修改清单（此次提交）

- 修改：`/lib/utils/auth/auth_store.dart`（isAdmin getter）
- 更新文档：`/docs_ai/2025_11/06_将管理员标识从is_admin迁移到role.md`

---

作者：自动化修改脚本
时间：2025-11-06
