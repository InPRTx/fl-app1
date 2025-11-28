# 用户购买记录用户ID点击跳转功能

## 日期

2025年11月06日

## 功能描述

在用户购买记录页面 (`UserBoughtListPage`) 中添加了点击用户ID跳转到用户详情页的功能，并修复了用户详情页缺少返回按钮的问题。

## 修改文件

- `/lib/pages/low_admin/user_bought_list.dart`
- `/lib/pages/low_admin/user_v2.dart`

## 主要变更

### 1. 导入 go_router

```dart
import 'package:go_router/go_router.dart';
```

### 2. 添加可点击的用户ID组件

新增 `_buildClickableUserIdItem` 方法，用于创建可点击的用户ID展示组件：

```dart
Widget _buildClickableUserIdItem(BuildContext context, int userId) {
  return InkWell(
    onTap: () {
      context.go('/low_admin/user_v2/$userId');
    },
    borderRadius: BorderRadius.circular(4),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '用户ID',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                userId.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.open_in_new,
                size: 12,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
```

### 3. 替换用户ID显示

将原来的 `_buildInfoItem` 调用替换为 `_buildClickableUserIdItem`：

```dart
Row
(
children: [
Expanded(
child: _buildClickableUserIdItem(
context,
record.userId,
),
),
// ...其他字段
],
)
,
```

## 功能特点

1. **视觉反馈**
    - 用户ID使用主题颜色显示
    - 添加下划线表示可点击
    - 使用 `InkWell` 提供点击水波纹效果

2. **导航图标**
    - 添加 `open_in_new` 图标，明确指示会跳转到新页面

3. **路由跳转**
    - 使用 `context.go()` 进行页面跳转
    - 路由路径: `/low_admin/user_v2/{userId}`
    - 无缝集成到现有的 go_router 路由系统

## 用户体验

- 用户可以直接点击购买记录中的用户ID查看该用户的详细信息
- 提供清晰的视觉提示，让用户知道该元素可点击
- 保持界面风格一致性，使用应用主题颜色

## 修复：添加返回按钮

### 问题

使用 `context.go()` 进行导航时，目标页面不会自动显示返回按钮。

### 解决方案

在 `user_v2.dart` 的 `AppBar` 中手动添加返回按钮：

```dart
import 'package:go_router/go_router.dart';

// ...

appBar: AppBar(
  title: Text('用户信息 - ID: ${widget.userId}'),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/low_admin/user_bought');
      }
    },
    tooltip: '返回',
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: _isLoading ? null : _loadUserData,
    ),
  ],
),
```

### 返回逻辑

1. **优先使用 `context.pop()`**：如果导航堆栈中有历史记录，则返回上一页
2. **备用 `context.go()`**：如果没有历史记录（例如直接访问 URL），则导航到购买记录页面

## 技术要点

- 遵循 Flutter Material Design 规范
- 使用 `InkWell` 提供触摸反馈
- 使用 `go_router` 进行声明式路由管理
- 智能返回按钮处理：优先使用浏览器历史记录，备用默认路由
- 保持代码简洁，无冗余的 try-catch 包装

