# 更新注册页面使用新的POW验证发送邮件

## 日期

2026-01-12

## 更新说明

根据API更新，发送邮箱验证码的接口已从使用 `tiago2CapToken` 改为使用 `verify_token`（POW验证令牌）。

## API 变更

### RequestEmailCodeParamsModel 更新

**变更前**:

```dart
class RequestEmailCodeParamsModel {
  const RequestEmailCodeParamsModel({
    required this.tiago2CapToken,
    this.email,
    this.captchaKey,
  });

  final String? email;
  final String? captchaKey;
  
  /// Tiago2的CAPTCHA令牌
  @JsonKey(name: 'tiago2_cap_token')
  final String tiago2CapToken;
}
```

**变更后**:

```dart
class RequestEmailCodeParamsModel {
  const RequestEmailCodeParamsModel({
    required this.verifyToken,
    this.email,
  });

  final String? email;
  
  /// POW验证令牌
  @JsonKey(name: 'verify_token')
  final String verifyToken;
}
```

**主要变化**:

- ❌ 移除 `tiago2CapToken` 字段
- ❌ 移除 `captchaKey` 字段
- ✅ 新增 `verifyToken` 字段（必填）

## 代码更新

### 1. 发送邮箱验证码函数

**修改前**:

```dart
Future<void> _sendEmailCode() async {
  // ...验证逻辑
  
  final RequestEmailCodeParamsModel body = RequestEmailCodeParamsModel(
    email: _emailController.text.trim(),
    tiago2CapToken: '1bd7ef93-4d71-4dcd-a1b7-c40f6a14b327',  // ❌ 旧方式
  );
  
  // ...API调用
}
```

**修改后**:

```dart
Future<void> _sendEmailCode() async {
  // ...验证逻辑
  
  // 检查是否已获取POW验证令牌
  if (_verifyToken == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('请先完成POW验证码验证'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  
  final RequestEmailCodeParamsModel body = RequestEmailCodeParamsModel(
    email: _emailController.text.trim(),
    verifyToken: _verifyToken!,  // ✅ 新方式，使用POW验证令牌
  );
  
  // ...API调用
}
```

### 2. UI 布局调整

#### 调整前的流程

```
1. 输入昵称
2. 输入邮箱
3. 发送验证码 ← 不需要POW验证
4. 输入验证码
5. 输入密码
6. 确认密码
7. 邀请码
8. POW验证 ← 在最后
9. 注册
```

#### 调整后的流程

```
1. 输入昵称
2. 输入邮箱
3. POW验证 ← 提前到这里
4. 发送验证码 ← 需要POW验证令牌
5. 输入验证码
6. 输入密码
7. 确认密码
8. 邀请码
9. 注册
```

### 3. 发送按钮禁用逻辑

**修改前**:

```dart
ElevatedButton.icon
(
onPressed: _isEmailValid && !_isSendingCode && _countdown == 0
? _sendEmailCode
:
null
,
// ...
)
```

**修改后**:

```dart
ElevatedButton.icon
(
onPressed: _isEmailValid && !_isSendingCode && _countdown == 0 && _verifyToken
!=
null
?
_sendEmailCode // ← 增加了 _verifyToken != null 条件
:
null
,
// ...
)
```

## 用户流程变化

### 修改前

```
用户输入邮箱 → 点击发送验证码 → 直接发送
```

### 修改后

```
用户输入邮箱 → 完成POW验证 → 点击发送验证码 → 使用POW令牌发送
```

## 安全性提升

### POW验证码集成的优势

1. **防止滥用**
    - 发送邮箱验证码需要先完成POW计算（约524万次SHA256）
    - 大幅增加了批量攻击的成本

2. **一次性使用**
    - 每个POW验证令牌只能使用一次
    - 发送验证码会消耗一个令牌

3. **IP绑定**
    - POW验证令牌与IP地址绑定
    - 防止令牌被盗用

4. **时间限制**
    - POW验证令牌有15分钟有效期
    - 过期需要重新验证

## UI改进

### POW验证区域位置

**移动位置**：从表单底部移到邮箱输入框后面

**原因**：

- ✅ 符合用户操作流程
- ✅ 用户知道需要先验证才能发送邮件
- ✅ 避免用户困惑为什么发送按钮禁用

### 发送按钮状态

发送验证码按钮现在需要同时满足以下条件才能点击：

1. ✅ 邮箱格式有效
2. ✅ 不在发送中
3. ✅ 倒计时为0
4. ✅ **已获取POW验证令牌** ← 新增

## 错误处理

### 新增的错误提示

当用户未完成POW验证就尝试发送验证码时：

```dart
ScaffoldMessenger.of
(
context).showSnackBar(
const SnackBar(
content: Text('请先完成POW验证码验证'),
backgroundColor: Colors.red
,
)
,
);
```

## 修改的文件

```
lib/page/auth/register/auth_register_page.dart
```

## 验证结果

### Flutter Analyze

```bash
flutter analyze
# 注册页面：0 errors ✅
# 其他文件有一些错误（与本次修改无关）
```

### 功能测试

#### 正确流程

```
1. 输入昵称 ✅
2. 输入邮箱 ✅
3. 点击"获取POW验证" ✅
4. 等待计算完成（显示绿色成功） ✅
5. 点击"发送验证码"（此时按钮才可用） ✅
6. 收到验证码，开始60秒倒计时 ✅
7. 继续完成注册流程 ✅
```

#### 错误流程处理

```
1. 输入邮箱
2. 未完成POW验证
3. 发送按钮禁用（灰色） ✅
4. 即使点击也无效 ✅
```

## 向后兼容性

### 不兼容的变更

- ❌ 旧版本的客户端无法使用新API
- ❌ 必须更新到使用 `verify_token` 的版本

### 迁移建议

1. 确保后端API已更新
2. 更新 Flutter 客户端代码
3. 测试完整的注册流程
4. 部署新版本

## 总结

成功将注册页面的发送邮箱验证码功能从旧的 `tiago2CapToken` 方式迁移到新的 POW 验证令牌方式。

### 关键改进

- ✅ 使用POW验证令牌代替固定token
- ✅ 调整UI布局，流程更合理
- ✅ 增加验证令牌检查
- ✅ 提升安全性
- ✅ 完整的错误处理

### 用户体验

- ✅ 清晰的操作流程
- ✅ 按钮状态明确
- ✅ 错误提示友好
- ✅ 防止误操作

## 文档版本

v1.0 - 2026-01-12

