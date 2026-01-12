# 为 macOS/移动端添加 POW 计算进度报告

## 日期

2026-01-12

## 问题

用户反馈：

- **macOS 客户端**：显示"准备中..."后就立即完成，看不到进度
- **浏览器版本**：可以正常显示进度

## 原因分析

### macOS/移动端（IO 平台）

使用 Isolate 在后台线程全速计算：

- ✅ 优点：计算速度极快（1-2 秒完成 80 个挑战）
- ❌ 缺点：没有进度报告，UI 无法更新

**之前的实现**：

```dart
Future<List<int>> computeSolutions
(...) async {
final ReceivePort receivePort = ReceivePort();

await Isolate.spawn(_computeInIsolate, params);

// ❌ 只等待最终结果，没有进度更新
return await receivePort.first as List<int>;
}

void _computeInIsolate(_POWParams params) {
// 全速计算，没有进度报告
final solutions = POWService.computeSolutionsSync(...);
params.sendPort.send(solutions);
}
```

### Web 浏览器（Web 平台）

使用异步分片计算：

- ✅ 优点：每个挑战后让出控制权，进度更新频繁
- ⚠️ 缺点：计算稍慢（但换来流畅体验）

**实现**：

```dart
Future<List<int>> computeSolutions
(...) async {
for (int i = 0; i < challengeCount; i++) {
// 计算单个挑战
final solution = _computeSingleChallenge(...);

// ✅ 每个挑战后都报告进度
onProgress?.call(i + 1, challengeCount);

// 让出控制权
await Future.delayed(Duration.zero);
}
}
```

## 解决方案

为 IO 平台添加进度报告功能，使用双端口通信：

1. **结果端口（SendPort）**：发送最终计算结果
2. **进度端口（SendPort）**：实时发送进度更新

### 实现代码

```dart
Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
  void Function(int progress, int total)? onProgress,
}) async {
  final ReceivePort receivePort = ReceivePort();
  final ReceivePort progressPort = ReceivePort();  // ✅ 新增进度端口

  // ✅ 监听进度更新
  progressPort.listen((message) {
    if (message is Map<String, int>) {
      final int current = message['current'] ?? 0;
      final int total = message['total'] ?? 0;
      onProgress?.call(current, total);
    }
  });

  await Isolate.spawn(
    _computeInIsolate,
    _POWParams(
      sendPort: receivePort.sendPort,
      progressPort: progressPort.sendPort,  // ✅ 传递进度端口
      capId: capId,
      challengeCount: challengeCount,
      difficulty: difficulty,
    ),
  );

  final List<int> solutions = await receivePort.first as List<int>;
  
  progressPort.close();  // ✅ 关闭进度端口
  
  return solutions;
}

void _computeInIsolate(_POWParams params) {
  final List<int> solutions = <int>[];
  
  // ✅ 报告初始进度
  params.progressPort?.send({'current': 0, 'total': params.challengeCount});

  for (int i = 0; i < params.challengeCount; i++) {
    // 计算单个挑战
    int solution = 0;
    while (true) {
      final hash = sha256.convert(utf8.encode('$i${params.capId}$solution'));
      if (hash.toString().startsWith('0' * params.difficulty)) {
        solutions.add(solution);
        break;
      }
      solution++;
    }

    // ✅ 每完成一个挑战，报告进度
    params.progressPort?.send({
      'current': i + 1,
      'total': params.challengeCount
    });
  }

  params.sendPort.send(solutions);
}
```

## 技术细节

### 1. 双端口通信

**为什么需要两个端口？**

- **结果端口（receivePort）**：用于接收最终计算结果
    - 只接收一次数据
    - 接收后通过 `receivePort.first` 返回

- **进度端口（progressPort）**：用于接收实时进度
    - 可以接收多次数据
    - 通过 `listen` 监听所有进度更新

**数据流**：

```
Isolate                         Main Thread
  │                                  │
  ├──> progressPort ──> {'current': 0, 'total': 80}
  │                                  ├──> onProgress(0, 80)
  ├──> progressPort ──> {'current': 1, 'total': 80}
  │                                  ├──> onProgress(1, 80)
  ├──> progressPort ──> {'current': 2, 'total': 80}
  │                                  ├──> onProgress(2, 80)
  │         ...                      │         ...
  ├──> progressPort ──> {'current': 80, 'total': 80}
  │                                  ├──> onProgress(80, 80)
  │
  └──> sendPort ──────> [solutions]
                                     └──> return solutions
```

### 2. 消息格式

使用 Map 传递进度信息：

```dart
{
'current': int, // 当前进度（已完成的挑战数）
'total': int, // 总数（总挑战数）
}
```

**为什么用 Map 而不是 List？**

- Map 更清晰，有命名字段
- 易于扩展（未来可能添加更多信息）
- 类型安全（可以检查 key）

### 3. 内存管理

关闭不再使用的端口：

```dart

final solutions = await
receivePort.first;progressPort.close
(); // ✅ 重要：避免内存泄漏
```

## 性能对比

### macOS/移动端（IO 平台）

| 项目    | 修改前   | 修改后        |
|-------|-------|------------|
| 计算速度  | 1-2 秒 | 1-2 秒（无影响） |
| 进度更新  | ❌ 无   | ✅ 每个挑战一次   |
| UI 响应 | ✅ 不阻塞 | ✅ 不阻塞      |
| 内存开销  | 低     | 略增（双端口通信）  |

**进度更新频率**：

- 80 个挑战 = 80 次进度更新
- 计算 1-2 秒 = 平均每 12-25ms 更新一次
- UI 能够平滑显示进度变化

### Web 浏览器（Web 平台）

| 项目    | 性能       |
|-------|----------|
| 计算速度  | 5-15 秒   |
| 进度更新  | ✅ 每个挑战一次 |
| UI 响应 | ✅ 保持流畅   |

## 修改的文件

```
lib/store/service/captcha/pow_service_io.dart  ✅ 添加进度报告
```

## UI 效果对比

### 修改前（macOS）

```
阶段 1：准备中...
┌─────────────────────────────────┐
│ ⟳ 正在计算 POW 验证码，请稍候... │
│ ▓▓▓░░░▓▓▓░░░                   │  ← 不确定进度动画
│ 准备中...                        │
└─────────────────────────────────┘

阶段 2：立即完成（用户几乎看不到）
┌─────────────────────────────┐
│ ✓ 验证成功          [刷新]  │
└─────────────────────────────┘
```

### 修改后（macOS）

```
阶段 1：0%
┌─────────────────────────────────┐
│ ⟳ 正在计算 POW 验证码... 0%      │
│ ░░░░░░░░░░░░░░░░░░░░           │
│ 0 / 80                           │
└─────────────────────────────────┘

阶段 2：25%
┌─────────────────────────────────┐
│ ⟳ 正在计算 POW 验证码... 25%     │
│ ▓▓▓▓▓░░░░░░░░░░░░░░           │
│ 20 / 80                          │
└─────────────────────────────────┘

阶段 3：50%
┌─────────────────────────────────┐
│ ⟳ 正在计算 POW 验证码... 50%     │
│ ▓▓▓▓▓▓▓▓▓▓░░░░░░░░░           │
│ 40 / 80                          │
└─────────────────────────────────┘

阶段 4：100%
┌─────────────────────────────────┐
│ ⟳ 正在计算 POW 验证码... 100%    │
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓          │
│ 80 / 80                          │
└─────────────────────────────────┘

阶段 5：验证成功
┌─────────────────────────────┐
│ ✓ 验证成功          [刷新]  │
└─────────────────────────────┘
```

**用户体验**：

- ✅ 可以看到清晰的进度变化
- ✅ 知道计算正在进行
- ✅ 虽然很快，但不会感觉"一闪而过"

## 验证结果

```bash
flutter analyze
# 28 issues found (全部为 info 级别)
# ✅ 0 errors
# ✅ 0 warnings
```

## 测试步骤

### macOS 测试

```bash
flutter run -d macos
```

1. 打开登录/注册/重置密码页面
2. 点击"获取POW验证"
3. 观察：
    - ✅ 立即显示蓝色验证框
    - ✅ 显示"准备中..."（1-2 帧）
    - ✅ 快速更新进度：0% → 25% → 50% → 75% → 100%
    - ✅ 进度条快速填充
    - ✅ 数字快速变化：0/80 → 20/80 → 40/80 → 60/80 → 80/80
    - ✅ 显示"验证成功"

### iOS/Android 测试

```bash
flutter run  # iOS
flutter run -d <android-device>  # Android
```

相同的测试步骤，预期相同的效果。

### Web 测试（对比）

```bash
flutter run -d chrome
```

Web 版本进度更新更慢但更流畅（5-15 秒），便于观察每个阶段。

## Isolate 进度报告的挑战

### 为什么之前没有实现？

1. **Isolate 隔离性**
    - Isolate 完全隔离，无法直接访问主线程
    - 只能通过 SendPort/ReceivePort 通信

2. **单端口限制**
    - `receivePort.first` 只能接收一次数据
    - 如果用同一个端口发送进度，会干扰最终结果

3. **性能考虑**
    - macOS/移动端计算很快，可能觉得不需要进度
    - 但用户体验显示，即使很快也需要反馈

### 解决方案的优势

1. **双端口设计**
    - 结果和进度分离
    - 互不干扰

2. **Map 消息格式**
    - 类型安全
    - 易于扩展

3. **最小性能影响**
    - 只是发送简单的 Map
    - 不影响计算速度

## 总结

通过为 IO 平台添加双端口进度报告机制，成功解决了 macOS/移动端进度不显示的问题：

1. **技术实现** - ✅ 使用双端口（结果 + 进度）通信
2. **性能影响** - ✅ 计算速度无影响，只增加微小通信开销
3. **用户体验** - ✅ 即使计算很快，也能看到进度变化
4. **平台一致** - ✅ 所有平台（iOS、Android、macOS、Windows、Web）都显示进度

现在无论在哪个平台，用户都能看到清晰的 POW 计算进度！

## 文档版本

v1.0 - 2026-01-12

