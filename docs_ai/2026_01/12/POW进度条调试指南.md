# POW 进度条调试指南

## 日期

2026-01-12

## 问题

注册页面看不到 POW 进度条

## 可能的原因

### 1. 平台检测问题

条件导入可能没有正确选择 Web 平台实现。

**验证方法**：
在浏览器控制台查看是否有 "POW Progress" 日志输出。

```
打开浏览器开发者工具 → Console 标签
点击"获取POW验证"
查看是否有类似输出：
POW Progress: 1 / 80
POW Progress: 2 / 80
...
```

### 2. 进度更新太快

虽然每次都调用 setState，但 Flutter 可能会批处理更新。

### 3. UI 条件判断问题

`if (_powTotal > 0)` 可能在某些情况下不满足。

## 修复方案

### 已添加的改进

1. **首次进度报告**
   在开始计算前就报告 `0 / 80`，确保 `_powTotal` 立即被设置。

```dart
// 首次报告进度（0/total）
onProgress?.call
(0, challengeCount);
```

2. **调试日志**
   在进度回调中添加 `print` 语句，方便调试。

```dart
onProgress: (int current, int total) {print
('POW Progress: 
$current / $total'); // ✅ 调试日志
if (mounted) {
setState(() {
_powProgress = current;
_powTotal = total;
});
}
}
,
```

## 调试步骤

### 步骤 1: 检查日志

```bash
# 运行 Web 版本
flutter run -d chrome --verbose
```

在浏览器控制台查看：

- ✅ 是否有 "POW Progress" 日志？
    - 有 → 进度回调正常工作，问题在 UI 层
    - 无 → 进度回调未被调用，问题在服务层

### 步骤 2: 检查状态变量

在注册页面的 `build` 方法中临时添加调试输出：

```dart
else if (_isVerifying)
Container(
padding: const EdgeInsets.all(12),
child: Column(
children: [
// ✅ 临时调试：显示状态变量
Text('Debug: _powProgress=$_powProgress, _powTotal=$_powTotal'),

Row(
children: [
CircularProgressIndicator(strokeWidth
:
2
)
,
// ...
```

### 步骤 3: 简化条件

如果进度条仍然不显示，尝试移除条件判断：

```dart
// 修改前
if (_powTotal > 0) ...<Widget>[
LinearProgressIndicator(...),
],

// 修改后（测试用）
...<Widget>[
LinearProgressIndicator(
value: _powTotal > 0 ? _powProgress /
_powTotal
:
0
,
)
,
]
,
```

## 预期行为

### 正常流程

```
1. 点击"获取POW验证"
   → _isVerifying = true
   → 显示蓝色容器

2. 开始计算
   → 调用 onProgress(0, 80)
   → _powTotal = 80
   → 显示进度条（0%）

3. 计算过程中
   → onProgress(1, 80) → 进度 1.25%
   → onProgress(2, 80) → 进度 2.5%
   → ...
   → onProgress(80, 80) → 进度 100%

4. 计算完成
   → _isVerifying = false
   → _verifyToken = "..."
   → 显示绿色"验证成功"
```

### UI 状态变化

```
未验证状态:
┌─────────────────────┐
│ [获取POW验证]        │
└─────────────────────┘

验证中（初始）:
┌─────────────────────────────┐
│ ⟳ 正在计算 POW 验证码... 0% │
│                              │
│ ░░░░░░░░░░░░░░░░░░░░        │
│ 0 / 80                       │
└─────────────────────────────┘

验证中（进行中）:
┌─────────────────────────────┐
│ ⟳ 正在计算 POW 验证码... 50% │
│                              │
│ ▓▓▓▓▓▓▓▓▓░░░░░░░░░░        │
│ 40 / 80                      │
└─────────────────────────────┘

验证成功:
┌─────────────────────────────┐
│ ✓ 验证成功         [刷新]   │
└─────────────────────────────┘
```

## 常见问题

### Q1: 只看到"正在计算..."，没有百分比

**原因**: `_powTotal` 仍然是 0

**解决**:

1. 检查控制台是否有日志
2. 确认进度回调是否被调用
3. 检查条件导入是否正确选择了 Web 实现

### Q2: 百分比显示了，但没有进度条

**原因**: `if (_powTotal > 0)` 条件可能有问题

**解决**:

```dart
// 检查这部分代码
if (_powTotal > 0) ...<Widget>[
const SizedBox(height: 8),
LinearProgressIndicator(
value:
_powProgress
/
_powTotal
,
// ...
)
,
]
,
```

### Q3: 进度条一闪而过

**原因**: 计算太快（可能是缓存或测试数据）

**解决**: 正常情况，说明功能正常工作

## 快速测试代码

在注册页面的 POW 验证 UI 部分，临时使用这个简化版本测试：

```dart
else if (_isVerifying)
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.blue.withValues(alpha: 0.1),
borderRadius: BorderRadius.circular(8),
border: Border.all(color: Colors.blue),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
// ✅ 调试信息
Text('状态: 正在验证'),
Text('进度: $_powProgress / $_powTotal'),
Text('百分比: ${_powTotal > 0 ? (_powProgress / _powTotal * 100).toInt() : 0}%'),

const SizedBox(height: 8),

// ✅ 进度条（移除条件）
LinearProgressIndicator(
value: _powTotal > 0 ? _powProgress / _powTotal : null,
backgroundColor: Colors.blue.withValues(alpha: 0.2),
valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
),
],
),
)
```

## 验证清单

- [ ] 控制台有 "POW Progress" 日志输出
- [ ] `_powTotal` 被设置为 80（或其他挑战数）
- [ ] `_powProgress` 从 0 递增到 80
- [ ] 百分比文本正确显示
- [ ] 进度条可见且逐渐填充
- [ ] 页面不卡死，可以滚动

## 下一步

如果调试日志显示进度回调正常工作，但 UI 仍然不更新，问题可能在：

1. **Flutter Web 的 setState 批处理**
    - 可能需要使用 `scheduleMicrotask` 强制立即更新

2. **条件渲染问题**
    - `if (_powTotal > 0)` 可能在某些边界情况下失效

3. **组件重建问题**
    - 父组件可能阻止了子组件更新

## 文档版本

v1.0 - 2026-01-12

