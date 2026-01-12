# JWT 令牌查看器功能实现

## 日期

2025年11月08日

## 功能描述

在系统调试页面中新增 JWT 令牌查看器功能，用于查看和解析访问令牌（Access Token）和刷新令牌（Refresh Token）。

## 实现内容

### 1. 新增页面

- **文件**: `/lib/page/system/debug/system_debug_jwt_token_page.dart`
- **类名**: `SystemDebugJwtTokenPage`

### 2. 主要功能

#### 2.1 令牌显示

- 显示完整的访问令牌和刷新令牌
- 令牌文本框使用大尺寸容器（最小高度 120px）
- 支持文本选择和复制
- 使用等宽字体显示，便于阅读

#### 2.2 令牌复制

- 每个令牌卡片右上角有复制按钮
- 点击复制后显示 SnackBar 提示
- 支持复制完整令牌和载荷数据

#### 2.3 令牌解析

- 自动解析 JWT 令牌的载荷（Payload）
- 显示以下信息：
    - **签发时间** (iat): 令牌创建时间
    - **过期时间** (exp): 令牌失效时间
    - **剩余时间**: 自动计算令牌剩余有效时间，显示为"X天 X小时 X分钟 X秒"
    - **状态**: 显示"有效"或"已过期"，带颜色标识（绿色/红色）

#### 2.4 载荷数据展示

- 以 JSON 格式展示完整的令牌载荷
- 使用缩进格式化，便于阅读
- 载荷数据框最小高度 150px
- 支持复制载荷数据

### 3. UI 设计

#### 3.1 令牌卡片

- 访问令牌使用蓝色主题 (Icons.vpn_key)
- 刷新令牌使用绿色主题 (Icons.refresh)
- 卡片包含标题、令牌文本框、信息区域和载荷数据区域

#### 3.2 状态标识

- 有效状态：绿色背景 + 绿色文字
- 过期状态：红色背景 + 红色文字
- 使用圆角标签样式

#### 3.3 数据框样式

- 浅灰色背景 (alpha: 0.1)
- 灰色边框 (alpha: 0.3)
- 圆角 8px
- 内边距 12px

### 4. 路由配置

- **路径**: `/system/debug/jwt_token`
- **路由名**: `system_debug_jwt_token`
- 在 `system_routes.dart` 中注册

### 5. 菜单入口

在 `system_debug_page.dart` 的调试工具卡片中添加菜单项：

- 图标: Icons.key
- 标题: JWT 令牌查看器
- 副标题: 查看和解析访问令牌与刷新令牌

## 技术实现

### 依赖包

- `jwt_decode: ^0.3.1` - JWT 令牌解析
- `intl` - 日期时间格式化
- `flutter/services.dart` - 剪贴板操作

### 核心方法

#### 令牌解析

```dart

Map<String, dynamic>? payload = Jwt.parseJwt(token);
```

#### 时间计算

```dart
// 过期时间
expirationTime = DateTime.fromMillisecondsSinceEpoch
(
(payload['exp'] as int) * 1000,
);

// 剩余时间
remainingTime = expirationTime.difference(DateTime.now());
isExpired = remainingTime.
isNegative;
```

#### 时间格式化

```dart
String _formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

String _formatDuration(Duration duration) {
  final days = duration.inDays;
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  final parts = <String>[];
  if (days > 0) parts.add('$days 天');
  if (hours > 0) parts.add('$hours 小时');
  if (minutes > 0) parts.add('$minutes 分钟');
  if (seconds > 0) parts.add('$seconds 秒');

  return parts.isEmpty ? '0 秒' : parts.join(' ');
}
```

#### 复制到剪贴板

```dart
Future<void> _copyToClipboard(String text, String message) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
```

## 用户体验优化

1. **无令牌处理**: 当令牌不存在时，显示友好提示"令牌不存在"
2. **错误处理**: JWT 解析失败时，只在控制台输出日志，不影响页面显示
3. **即时反馈**: 复制操作后立即显示 SnackBar 提示
4. **可读性**: 使用等宽字体、JSON 缩进、颜色标识等提升可读性
5. **信息完整**: 同时显示原始令牌和解析后的数据，满足不同需求

## 测试建议

1. 登录后访问页面，验证令牌正常显示
2. 测试复制功能，确认剪贴板内容正确
3. 验证时间计算准确性（签发时间、过期时间、剩余时间）
4. 测试令牌过期状态的显示（红色标识）
5. 登出后访问页面，验证"令牌不存在"提示

## 文件清单

### 新增文件

- `/lib/page/system/debug/system_debug_jwt_token_page.dart`

### 修改文件

- `/lib/router/system_routes.dart` - 添加路由配置
- `/lib/page/system/debug/system_debug_page.dart` - 添加菜单入口

## 符合规范

✅ 使用 2 空格缩进  
✅ 使用尾逗号格式化  
✅ 命名规范：小写+下划线（文件）、大驼峰（类）、小驼峰（变量）  
✅ 所有字段明确类型  
✅ Widget 构造使用 `Key? key` 参数  
✅ 使用 `const` 构造函数  
✅ 避免魔数，使用明确的常量值  
✅ 遵循 Flutter 最佳实践

