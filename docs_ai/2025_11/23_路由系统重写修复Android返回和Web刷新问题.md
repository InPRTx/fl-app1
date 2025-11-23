# 路由系统重写 - 修复 Android 返回和 Web 刷新问题

## 问题描述

### 原始问题
1. **Android 平台**：按返回按钮时总是返回到系统桌面，而不是返回到应用内的上一级页面
2. **Web 平台**：刷新页面后，返回按钮不显示

### 问题原因分析

#### Android 返回问题
- `AndroidManifest.xml` 中设置了 `android:taskAffinity=""` 和 `android:launchMode="singleTop"`
- 这个配置导致应用的 Activity 没有正确的任务栈关联
- 当用户按返回键时，系统认为应该退出应用而不是返回上一页

#### Web 刷新问题
- 部分页面的 AppBar 没有正确检查是否可以返回
- 刷新后路由栈被清空，但页面仍然显示返回按钮
- 返回按钮的行为不一致

## 解决方案

### 1. Android 平台修复

#### AndroidManifest.xml 修改

**修改前：**
```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:taskAffinity=""
    ...>
```

**修改后：**
```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTask"
    ...>
```

**关键变更：**
- 移除 `android:taskAffinity=""`：确保 Activity 使用正确的任务栈
- 将 `android:launchMode` 从 `singleTop` 改为 `singleTask`：确保应用在单个任务中运行，同时保持实例唯一性

#### main.dart 添加系统返回键处理

在 `MaterialApp.router` 外添加 `PopScope` 包装器：

```dart
builder: (context, child) {
  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      if (didPop) {
        return;
      }
      
      final router = GoRouter.of(context);
      if (router.canPop()) {
        router.pop();
      } else {
        // 如果无法返回，显示退出确认对话框
        showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('确认退出'),
            content: const Text('确定要退出应用吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  SystemNavigator.pop();
                },
                child: const Text('退出'),
              ),
            ],
          ),
        );
      }
    },
    child: child!,
  );
},
```

### 2. Web 平台修复

#### 启用路由调试日志

在 `router/index.dart` 中：

```dart
final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // 启用调试日志
  routes: <RouteBase>[
    // ...
  ],
);
```

#### 统一返回按钮处理

所有页面的 AppBar 返回按钮应该使用统一的逻辑：

```dart
leading: IconButton(
  icon: const Icon(Icons.arrow_back),
  onPressed: () {
    // 使用 canPop 检查是否可以返回
    // 这在 Web 平台刷新后也能正确工作
    if (context.canPop()) {
      context.pop();
    } else {
      // 如果有 fallback 路由，导航到该路由
      context.go('/fallback_route');
    }
  },
  tooltip: '返回',
),
```

### 3. 路由配置优化

#### 移除 Navigator API 使用

**修改前（使用 Navigator.push）：**
```dart
Future<void> _navigateToRecharge() async {
  final result = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (context) =>
          LowAdminUserMoneyRechargePage(userId: widget.userId),
    ),
  );
  if (result == true) {
    await _loadUserData();
  }
}
```

**修改后（使用 GoRouter）：**

1. 在路由表中添加路由：
```dart
GoRoute(
  path: '/low_admin/user_v2/:id/recharge',
  name: 'user_recharge',
  builder: (context, state) {
    final id = int.tryParse(state.pathParameters['id'] ?? '');
    if (id == null) {
      return const Scaffold(body: Center(child: Text('invalid id')));
    }
    return LowAdminUserMoneyRechargePage(userId: id);
  },
),
```

2. 使用 context.push 导航：
```dart
Future<void> _navigateToRecharge() async {
  await context.push('/low_admin/user_v2/${widget.userId}/recharge');
  await _loadUserData();
}
```

#### 抽屉导航优化

**修改前：**
```dart
onTap: () {
  Navigator.pop(context);  // 关闭抽屉
  context.go(item.route!);
},
```

**修改后：**
```dart
onTap: () {
  if (Scaffold.of(context).hasDrawer) {
    Scaffold.of(context).closeDrawer();  // 正确关闭抽屉
  }
  context.go(item.route!);
},
```

### 4. 创建可复用组件

创建了 `AppBarWithBackComponent` 组件用于统一返回按钮行为：

```dart
class AppBarWithBackComponent extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final String? fallbackRoute;
  final PreferredSizeWidget? bottom;

  const AppBarWithBackComponent({
    super.key,
    required this.title,
    this.actions,
    this.fallbackRoute,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      bottom: bottom,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else if (fallbackRoute != null) {
            context.go(fallbackRoute!);
          } else {
            context.go('/');
          }
        },
        tooltip: '返回',
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
```

## 修改文件清单

### 核心文件
1. `android/app/src/main/AndroidManifest.xml` - Android 配置修复
2. `lib/main.dart` - 添加系统返回键处理
3. `lib/router/index.dart` - 启用调试日志

### 路由配置
4. `lib/router/low_admin_routes.dart` - 添加充值页面路由
5. `lib/router/system_routes.dart` - 添加系统常量查看页路由

### 组件
6. `lib/component/common/app_bar_with_back_component.dart` - 新建统一返回按钮组件
7. `lib/component/layout/simple_layout_with_menu_component.dart` - 优化抽屉关闭

### 页面
8. `lib/page/home_page.dart` - 使用 GoRouter 替代 Navigator
9. `lib/page/low_admin/low_admin_layout.dart` - 优化抽屉导航
10. `lib/page/low_admin/user_detail/low_admin_user_detail_page.dart` - 使用 GoRouter 导航
11. `lib/page/low_admin/user_money_recharge/low_admin_user_money_recharge_page.dart` - 使用 context.pop()

## 测试要点

### Android 平台
- [ ] 在任何页面按返回键，应该返回上一页而不是退出应用
- [ ] 在首页按返回键，应该显示退出确认对话框
- [ ] 多级页面导航后连续按返回键，应该逐级返回

### Web 平台
- [ ] 刷新任何非首页页面，返回按钮应该正确显示
- [ ] 点击返回按钮，应该返回上一页或指定的 fallback 路由
- [ ] 浏览器的前进/后退按钮应该正常工作

### iOS 平台
- [ ] 左滑返回手势应该正常工作
- [ ] 返回按钮行为与 Android 一致

## 最佳实践

### 导航规范

1. **页面导航**：使用 `context.go()` 或 `context.push()`
2. **返回操作**：使用 `context.pop()` 或 `context.canPop()` 检查
3. **对话框关闭**：使用 `Navigator.pop(context, result)`（对话框不属于路由栈，这是标准做法）
4. **路由定义**：所有页面都应该在路由表中定义，避免使用 `Navigator.push()`

### Navigator API 使用场景

虽然我们迁移到了 GoRouter，但以下场景仍然使用 Navigator API（这是正确的）：

- **对话框**（AlertDialog, SimpleDialog）
- **底部表单**（showModalBottomSheet）
- **通用对话框**（showGeneralDialog）
- **日期/时间选择器**等模态窗口

这些都不属于应用的路由栈，而是临时的 UI 元素，因此使用 Navigator.pop() 是正确且推荐的做法。

### AppBar 规范

```dart
AppBar(
  title: Text('页面标题'),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/fallback_route');
      }
    },
    tooltip: '返回',
  ),
  actions: [
    // 其他操作按钮
  ],
)
```

### 对话框/抽屉关闭

- **对话框**：继续使用 `Navigator.pop(context, result)`（这是 Flutter 标准做法，对话框不属于路由栈）
- **抽屉**：使用 `Scaffold.of(context).closeDrawer()`
- **底部表单**：使用 `Navigator.pop(context, result)`

示例：
```dart
// 对话框关闭 - 使用 Navigator.pop
showDialog(
  context: context,
  builder: (dialogContext) => AlertDialog(
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(dialogContext, result),
        child: const Text('确定'),
      ),
    ],
  ),
);

// 抽屉关闭 - 使用 Scaffold API
if (Scaffold.of(context).hasDrawer) {
  Scaffold.of(context).closeDrawer();
}
```

## 技术说明

### PopScope vs WillPopScope

在 Flutter 3.12+ 中，`WillPopScope` 已被弃用，应使用 `PopScope`：

```dart
PopScope(
  canPop: false,  // 禁止直接返回
  onPopInvokedWithResult: (didPop, result) {
    // 自定义返回逻辑
  },
  child: child,
)
```

### GoRouter 路由栈管理

- `context.go()` - 替换整个路由栈
- `context.push()` - 在当前路由上推入新路由
- `context.pop()` - 弹出当前路由
- `context.canPop()` - 检查是否可以弹出

### Android LaunchMode 说明

- `standard` - 每次启动都创建新实例
- `singleTop` - 如果实例在栈顶则复用
- `singleTask` - 整个系统中只有一个实例（推荐用于单 Activity 应用）
- `singleInstance` - 独占一个任务栈

## 参考资料

- [GoRouter 官方文档](https://pub.dev/packages/go_router)
- [Android Task and Back Stack](https://developer.android.com/guide/components/activities/tasks-and-back-stack)
- [Flutter Navigation and Routing](https://docs.flutter.dev/ui/navigation)
