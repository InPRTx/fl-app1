# 主题色更改和用户菜单栏实现总结

## 完成的工作

### 1. 创建用户侧边栏菜单

**文件**: `/lib/widgets/user_sidebar.dart`

- 实现了完整的用户中心侧边栏导航菜单
- 包含所有 `/user` 路径下的功能入口
- 使用 Material Design 3 的主题颜色系统
- 支持可展开的子菜单
- 根据当前路由高亮显示当前页面

**菜单结构**:

- 用户中心
    - 主页
    - 产品服务（子菜单：我的服务、商品购买记录、续费服务、购买服务、附加服务）
    - 财务管理（子菜单：我的账单、我的充值、账户充值、兑换码）
    - 技术支持（子菜单：节点列表、重置连接信息、我的工单、公告信息、知识库）
    - 服务使用（子菜单：流量使用情况、共享账户、审计规则、审计记录）
    - 我的账户
    - 提交工单
    - 用户推广
- 其他设置
    - 设置
    - 关于我们

### 2. 创建用户布局组件

**文件**: `/lib/widgets/user_layout.dart`

- 统一的用户页面布局组件
- 集成侧边栏抽屉菜单
- 使用主题颜色的 AppBar
- 所有 `/user` 路径页面都可以使用此布局

### 3. 更新所有组件使用主题颜色

#### Dashboard 页面 (`/lib/pages/user/dashboard.dart`)

**改动**:

- 使用 `UserLayout` 包装页面，添加侧边栏菜单
- 背景渐变色改为使用 `theme.colorScheme.primaryContainer` 和 `theme.colorScheme.surface`
- 错误提示容器使用 `theme.colorScheme.errorContainer` 和相关颜色
- 状态卡片使用 `primary`、`secondary`、`tertiary` 主题颜色
- 赞助商卡片使用 `surfaceContainerHighest` 和主题颜色

#### 公告卡片 (`/lib/widgets/dashboard/announcement_card.dart`)

**改动**:

- 卡片头部使用 `theme.colorScheme.primary`
- 文字颜色使用 `theme.colorScheme.onPrimary`
- 正文使用 `theme.textTheme.bodyMedium`

#### 订阅配置卡片 (`/lib/widgets/dashboard/subscription_card.dart`)

**改动**:

- 卡片头部使用 `theme.colorScheme.secondary`
- 标题文字使用 `theme.textTheme.titleSmall` 和 `titleLarge`
- 容器背景使用 `surfaceContainerHighest` 和 `surfaceContainerHigh`
- 边框使用 `theme.colorScheme.outline`
- 图标使用 `theme.colorScheme.secondary`

#### 流量使用卡片 (`/lib/widgets/dashboard/traffic_card.dart`)

**改动**:

- 卡片头部使用 `theme.colorScheme.tertiary`
- 进度条背景使用 `surfaceContainerHighest`
- 进度条颜色根据使用率动态显示（error/tertiary/primary）
- 剩余流量和今日使用信息框使用 `primary` 和 `secondary` 颜色
- 过期时间容器使用 `primaryContainer`
- 按钮使用 `primary` 和 `secondary` 主题颜色
- 所有文字样式使用 `theme.textTheme`

### 4. 主题颜色映射

原有硬编码颜色 → 新的主题颜色：

- `Colors.deepPurple` → `theme.colorScheme.primary`
- `Colors.blue` → `theme.colorScheme.primary` 或 `secondary`
- `Colors.purple` → `theme.colorScheme.tertiary`
- `Colors.green` → `theme.colorScheme.primary`
- `Colors.orange` → `theme.colorScheme.tertiary`
- `Colors.red` → `theme.colorScheme.error`
- `Colors.amber` → `theme.colorScheme.primary`
- `Colors.grey.shade*` → `theme.colorScheme.surfaceContainerHighest` 等

### 5. 图标映射

由于 Flutter 使用 Material Icons 而不是 MDI，进行了图标映射：

- `mdi-account-circle` → `Icons.account_circle`
- `mdi-cube-outline` → `Icons.shopping_bag_outlined`
- `mdi-currency-usd` → `Icons.attach_money`
- `mdi-lifebuoy` → `Icons.support_agent_outlined`
- `mdi-cloud-upload` → `Icons.cloud_upload_outlined`
- 等等...

## 优势

1. **一致性**: 所有颜色都基于主题系统，保证视觉一致性
2. **可维护性**: 只需在 `main.dart` 中修改 `ColorScheme.fromSeed` 的 `seedColor` 即可更改整个应用的色调
3. **响应式**: 颜色会自动适配亮色/暗色主题
4. **Material Design 3**: 完全遵循 MD3 设计规范
5. **可访问性**: 主题系统自动处理对比度和可读性

## 如何修改主题色

在 `/lib/main.dart` 中修改：

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,  // 修改这里即可更改整个主题
  ),
),
```

可以尝试的颜色：

- `Colors.blue`
- `Colors.green`
- `Colors.teal`
- `Colors.indigo`
- `Colors.purple`
- 或任何自定义颜色 `Color(0xFF123456)`

## 侧边栏使用方法

在任何 `/user` 路径的页面中，使用 `UserLayout` 包装：

```dart
return UserLayout(
  title: '页面标题',
  child: YourPageContent(),
);
```

这样页面就会自动获得：

- 统一的 AppBar
- 左侧抽屉式菜单
- 当前路由高亮
- 主题颜色应用

## 测试建议

1. 访问 `/user/dashboard` 查看主页效果
2. 点击左上角菜单图标打开侧边栏
3. 尝试点击不同菜单项（当前已实现的路由会跳转，未实现的路由会显示错误）
4. 在 `main.dart` 中修改 `seedColor` 查看不同主题色效果

## 后续扩展

如果需要为其他路径（如 `/admin`）创建单独的菜单栏，可以：

1. 复制 `user_sidebar.dart` 创建 `admin_sidebar.dart`
2. 定义新的菜单结构
3. 创建 `AdminLayout` 组件
4. 在相应页面中使用

