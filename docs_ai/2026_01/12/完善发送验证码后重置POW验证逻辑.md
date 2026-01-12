# 完善发送验证码后重置 POW 验证逻辑

## 日期

2026-01-12

## 修改说明

确保无论发送验证码成功还是失败，都会重置 POW 验证状态，这样每次发送都需要重新获取 POW 验证。

## 修改内容

### 之前的问题

之前的代码只在成功时重置 POW 验证令牌：

```dart
if (response.isSuccess) {
setState(() {
_emailCodeSent = true;
// ✅ 只在成功时重置
_verifyToken = null;
_captchaError = null;
});
// ...
} else {
// ❌ 失败时没有重置
ScaffoldMessenger.of(context).showSnackBar(...);
}
```

### 修改后的实现

现在无论成功还是失败都重置：

```dart
// API 调用后，立即重置 POW（无论成功失败）
setState
(
() {
_isSendingCode = false;
// ✅ 无论成功还是失败，都重置 POW 验证令牌
_verifyToken = null;
_captchaError = null;
});

if (response.isSuccess) {
setState(() {
_emailCodeSent = true;
});
// ...
} else {
// 显示失败消息
// ...
}
```

### 异常处理中也重置

```dart
} on DioException catch (e) {
if (!mounted) return;

setState(() {
_isSendingCode = false;
// ✅ 网络异常也要重置 POW 验证令牌
_verifyToken = null;
_captchaError = null;
});

ScaffoldMessenger.of(context).showSnackBar(...);
} catch (e) {
if (!mounted) return;

setState(() {
_isSendingCode = false;
// ✅ 其他异常也要重置 POW 验证令牌
_verifyToken = null;
_captchaError = null;
});

ScaffoldMessenger.of(context).showSnackBar(...);
}
```

## 覆盖的场景

### 场景 1：发送成功

```
1. 点击"发送验证码"
   → API 调用成功
   → ✅ 重置 POW 验证令牌
   → 显示成功提示
   → POW 区域变为"获取POW验证"按钮
```

### 场景 2：发送失败（API 返回失败）

```
1. 点击"发送验证码"
   → API 调用成功但返回 isSuccess: false
   → ✅ 重置 POW 验证令牌
   → 显示失败提示
   → POW 区域变为"获取POW验证"按钮
```

### 场景 3：网络异常

```
1. 点击"发送验证码"
   → 网络超时或连接失败
   → ✅ 重置 POW 验证令牌
   → 显示网络错误提示
   → POW 区域变为"获取POW验证"按钮
```

### 场景 4：其他异常

```
1. 点击"发送验证码"
   → 发生未预期的异常
   → ✅ 重置 POW 验证令牌
   → 显示错误提示
   → POW 区域变为"获取POW验证"按钮
```

## 安全性增强

### 1. POW 令牌一次性使用

无论发送结果如何，POW 令牌都被消耗：

- ✅ 成功发送：令牌被消耗
- ✅ 失败发送：令牌也被消耗
- ✅ 网络异常：令牌也被消耗

### 2. 防止重试攻击

即使发送失败，用户也必须重新获取 POW 才能再次尝试：

- ✅ 增加了快速重试的成本
- ✅ 防止自动化脚本快速重试
- ✅ 每次尝试都需要重新计算 POW（3-8秒）

### 3. 防止令牌复用

确保 POW 令牌不会被复用：

- ✅ 使用一次后立即失效
- ✅ 无论成功失败都失效
- ✅ 异常情况也失效

## 用户体验

### 对用户的影响

**正常情况（发送成功）**：

```
1. 获取 POW 验证 → 发送验证码 → 成功
   → POW 区域重置
   → 需要重新获取 POW 才能再次发送
   → 符合预期
```

**异常情况（发送失败）**：

```
1. 获取 POW 验证 → 发送验证码 → 失败
   → POW 区域重置
   → 需要重新获取 POW 才能重试
   → 增加了一步操作，但提高了安全性
```

### 权衡

**优点**：

- ✅ 更高的安全性
- ✅ 防止快速重试攻击
- ✅ 一致的行为（成功/失败都重置）

**缺点**：

- ⚠️ 发送失败后用户需要重新获取 POW（额外等待 3-8 秒）

**结论**：安全性优先，可接受的用户体验成本。

## 代码位置

### 修改的位置

```
lib/page/auth/reset_password/auth_reset_password_page.dart

行 195-240: _sendEmailCode 函数
  - 行 199-204: 成功/失败都重置 POW
  - 行 229-235: DioException 中重置 POW
  - 行 236-242: 其他异常中重置 POW
```

## 验证结果

```bash
flutter analyze lib/page/auth/reset_password/auth_reset_password_page.dart
# No issues found! ✅
```

## 总结

通过在所有发送验证码的代码路径中都重置 POW 验证令牌，确保了：

1. **安全性最大化** - POW 令牌一次性使用，无论成功失败
2. **行为一致性** - 所有情况都重置，不会有遗漏
3. **防止攻击** - 增加了快速重试的成本

这是一个安全优先的设计，虽然失败后需要重新获取 POW 会增加一点用户操作成本，但能有效防止恶意攻击。

## 文档版本

v1.0 - 2026-01-12

