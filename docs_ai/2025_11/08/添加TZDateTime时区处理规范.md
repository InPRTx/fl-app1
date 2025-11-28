# 添加 TZDateTime 时区处理规范

## 概述

在 `.github/copilot-instructions.md` 中添加了使用 `timezone` 包中的 `TZDateTime` 进行时区处理的详细文档。

## 背景

在处理时间数据时，除了基本的 `DateTime.toLocal()` 和 `DateTime.toUtc()` 转换外，有时需要更精确的时区控制。`timezone` 包提供了
`TZDateTime` 类来处理这种场景。

## 新增内容

### 核心使用场景

1. **从 API 读取时间并转换为本地时区**
   ```dart
   final tz.TZDateTime? localExpireAt = apiDateTime != null
       ? tz.TZDateTime.from(apiDateTime, tz.local)
       : null;
   ```

2. **显示时间**
   ```dart
   final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
   final tz.TZDateTime localTime = tz.TZDateTime.from(dateTime, tz.local);
   Text(dateFormat.format(localTime))
   ```

3. **时间比较**
   ```dart
   final bool isExpired = localExpireAt != null &&
       localExpireAt.isBefore(tz.TZDateTime.now(tz.local));
   ```

4. **提交数据到 API**
   ```dart
   final DateTime utcTime = localTime.toUtc();
   final body = UpdateModel(expireAt: utcTime);
   ```

### 实际应用示例

参考 `lib/page/low_admin/user_bought_list/low_admin_user_bought_list_page.dart` 中的实现：

- 购买记录列表中的时间显示
- 过期时间判断
- 时间状态标签（已过期/有效）

## 关键点

1. ✅ 使用 `tz.TZDateTime.from(dateTime, tz.local)` 将 UTC 转为本地时区
2. ✅ 使用 `tz.TZDateTime.now(tz.local)` 获取当前本地时区时间
3. ✅ 时间比较时确保两个时间都在同一时区（都用 `tz.local`）
4. ✅ 显示时间前先转换为本地时区，再格式化
5. ✅ 提交 API 时使用 `.toUtc()` 转回 UTC 时间
6. ✅ `tz.local` 会自动使用设备的系统时区

## 依赖包

```yaml
dependencies:
  timezone: ^0.9.0
  intl: ^0.18.0
```

## 导入方式

```dart
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
```

## 文档位置

`.github/copilot-instructions.md` 中的 "DateTime 时间处理规范" 章节

## 修改时间

2025年11月08日

