# 登录页POW验证码用时显示优化

## 优化时间

2026-01-14

## 文件路径

`/lib/page/auth/login/auth_login_page.dart`

## 优化内容

### 1. 新增状态变量

添加了两个新的状态变量来跟踪POW验证的时间信息:

```dart
DateTime? _verifyStartTime; // 验证开始时间
Duration? _verifyDuration; // 验证总用时
```

### 2. 记录验证开始时间

在 `_handlePOWVerify()` 方法中,当开始验证时记录当前时间:

```dart
setState
(
() {
_isVerifying = true;
_captchaError = null;
_verifyToken = null;
_powProgress = 0;
_powTotal = 0;
_verifyStartTime = DateTime.now(); // 记录开始时间
_verifyDuration = null;
});
```

### 3. 计算验证用时

在验证成功后,计算从开始到完成的时间差:

```dart
if (verifyToken.isNotEmpty) {
final Duration duration = DateTime.now().difference(_verifyStartTime!);
setState(() {
_verifyToken = verifyToken;
_isVerifying = false;
_powProgress = 0;
_powTotal = 0;
_verifyDuration = duration; // 保存用时
});
}
```

### 4. 显示验证用时

在UI中展示验证成功及用时信息:

#### 4.1 SnackBar提示

验证完成后立即显示带用时的提示:

```dart
ScaffoldMessenger.of
(
context).showSnackBar(
SnackBar(
content: Text('POW验证码验证成功 (用时: ${duration.inSeconds}.${(duration.inMilliseconds % 1000).toString().padLeft(3, '0')}秒)'),
backgroundColor: Colors.green,
)
,
);
```

#### 4.2 验证成功状态卡片

在表单中持久显示验证成功状态和用时:

```dart
Container
(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.green.withValues(alpha: 0.1),
borderRadius: BorderRadius.circular(8),
border: Border.all(color: Colors.green),
),
child: Row(
children: <Widget>[
const Icon(Icons.check_circle, color: Colors.green),
const SizedBox(width: 8),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
const Text(
'验证成功',
style: TextStyle(
color: Colors.green,
fontWeight: FontWeight.bold,
),
),
if (_verifyDuration != null)
Text(
'用时: ${_verifyDuration!.inSeconds}.${(_verifyDuration!.inMilliseconds % 1000).toString().padLeft(3, '0')}秒',
style: TextStyle(
color: Colors.green.shade700,
fontSize: 12,
),
),
],
),
),
IconButton(
icon: const Icon(Icons.refresh),
onPressed: () {
setState(() {
_verifyToken = null;
_captchaError = null;
_verifyDuration = null; // 清除用时
});
},
)
,
]
,
)
,
)
```

### 5. 错误处理

在验证失败时,重置时间相关状态:

```dart
.catchError((Object e) {
setState(() {
_captchaError = e.toString();
_isVerifying = false;
_powProgress = 0;
_powTotal = 0;
_verifyStartTime = null;
_verifyDuration = null;
});
return '';
});
```

## 用户体验改进

1. **即时反馈**: 验证完成后立即通过SnackBar告知用户用时
2. **持久显示**: 在验证成功状态卡片中持续显示用时,方便用户查看
3. **精确度**: 显示秒数和毫秒数(格式: X.XXX秒),提供精确的时间信息
4. **清晰状态**: 用户可以清楚地看到验证耗时,了解系统性能

## 时间格式

使用以下格式显示时间:

- 秒数: `duration.inSeconds`
- 毫秒数(补零到3位): `(duration.inMilliseconds % 1000).toString().padLeft(3, '0')`
- 最终格式: `X.XXX秒`

例如:

- 1.234秒
- 5.067秒
- 12.890秒

## 技术要点

1. 使用 `DateTime.now()` 获取当前时间
2. 使用 `DateTime.difference()` 计算时间差
3. 使用 `Duration` 对象存储和展示时间间隔
4. 状态重置时同时清除时间相关变量,避免显示过期数据

## 后续优化建议

1. 可以添加平均用时统计功能
2. 可以根据用时长短显示不同颜色(快速/正常/慢速)
3. 可以添加用时历史记录功能

