# Base URL 动态配置功能实现

## 日期

2025年11月08日

## 操作说明

实现了动态配置 API Base URL 的功能，允许用户在应用内修改 API 服务器地址。

## 实现内容

### 1. 创建 BaseUrlStore (lib/store/base_url_store.dart)

使用单例模式创建了 `BaseUrlStore` 类，用于管理 Base URL 的存储和获取：

**核心功能：**

- 使用 `shared_preferences` 持久化存储自定义 Base URL
- 支持从编译时环境变量 `BASE_URL` 读取默认值
- 提供恢复默认配置功能
- 实现 `ChangeNotifier` 支持状态监听

**关键属性：**

- `baseUrl`: 获取当前有效的 Base URL（自定义或默认）
- `defaultBaseUrl`: 获取编译时的默认 Base URL
- `isUsingCustom`: 判断是否使用自定义配置

**关键方法：**

- `init()`: 初始化并从 shared_preferences 加载保存的配置
- `setCustomBaseUrl(String? url)`: 设置自定义 Base URL
- `resetToDefault()`: 恢复为默认 Base URL

### 2. 创建 Base URL 配置页面 (lib/page/system/debug/system_debug_base_url_page.dart)

创建了完整的 UI 页面用于查看和修改 Base URL：

**页面功能：**

- 显示当前使用的 Base URL
- 显示默认的 Base URL（从环境变量读取）
- 显示配置状态（使用自定义/使用默认）
- 支持一键复制 URL 到剪贴板
- 表单验证（URL 格式检查）
- 保存自定义 Base URL
- 恢复默认配置
- 注意事项提示

**UI 特性：**

- 使用 Card 组件分区显示不同信息
- 使用 Form 和 TextFormField 进行输入验证
- URL 必须以 http:// 或 https:// 开头
- 提供友好的错误提示和保存成功提示

### 3. 更新路由配置 (lib/router/system_routes.dart)

添加了新的路由：

```dart
GoRoute(
  path: '/system/debug/base_url',
  name: 'system_debug_base_url',
  builder: (context, state) => const SystemDebugBaseUrlPage(),
),
```

### 4. 更新调试菜单 (lib/page/system/debug/system_debug_page.dart)

在调试工具页面添加了 "Base URL 配置" 入口：

```dart
ListTile(
  leading: const Icon(Icons.link),
  title: const Text('Base URL 配置'),
  subtitle: const Text('配置 API 服务器地址'),
  trailing: const Icon(Icons.chevron_right),
  onTap: () {
    context.go('/system/debug/base_url');
  },
),
```

### 5. 更新 Base URL 定义 (lib/api/base_url.dart)

将原来的 `const String` 改为使用 `BaseUrlStore` 的 getter：

```dart
String get kDefaultBaseUrl => BaseUrlStore().baseUrl;
```

**注意：** 由于改为 getter，值在运行时从 store 中读取，支持动态更新。

### 6. 初始化配置 (lib/main.dart)

在应用启动时初始化 `BaseUrlStore`：

```dart
// Initialize BaseUrlStore to get saved base URL
await BaseUrlStore().init();
```

确保在其他需要使用 Base URL 的组件之前完成初始化。

## 使用方式

### 方式一：应用内配置

1. 启动应用
2. 导航到 `/system/debug`
3. 点击 "Base URL 配置"
4. 输入新的 Base URL（必须以 http:// 或 https:// 开头）
5. 点击 "保存"
6. 重启应用使配置生效

### 方式二：编译时指定

使用 `--dart-define` 参数：

```bash
flutter run --dart-define=BASE_URL=https://api.example.com
flutter build apk --dart-define=BASE_URL=https://api.example.com
```

### 方式三：恢复默认

在 Base URL 配置页面点击 "恢复默认" 按钮。

## 技术要点

### 单例模式

```dart
class BaseUrlStore extends ChangeNotifier {
  static final BaseUrlStore _instance = BaseUrlStore._internal();
  factory BaseUrlStore() => _instance;
  BaseUrlStore._internal();
}
```

遵循项目规范，使用单例模式确保全局状态一致性。

### 优先级

1. 用户在应用内设置的自定义 URL（最高优先级）
2. 编译时通过 `--dart-define` 指定的 URL
3. 代码中的硬编码默认值（最低优先级）

### 数据持久化

使用 `shared_preferences` 存储配置：

- Key: `app_base_url`
- 当值为空或与默认值相同时，清除存储
- 支持跨应用启动保持配置

### 状态通知

`BaseUrlStore` 继承 `ChangeNotifier`，在配置改变时：

- 调用 `notifyListeners()` 通知监听者
- UI 自动更新显示最新状态

## 注意事项

1. **重启生效**：修改 Base URL 后需要重启应用才能生效（因为很多 API 客户端在启动时初始化）
2. **URL 验证**：确保输入的 URL 格式正确，包含协议头（http:// 或 https://）
3. **网络测试**：修改后建议先测试新 URL 是否可访问
4. **恢复默认**：遇到问题时可以随时恢复默认配置

## 文件清单

新增文件：

- `/lib/store/base_url_store.dart` - Base URL 状态管理
- `/lib/page/system/debug/system_debug_base_url_page.dart` - Base URL 配置页面

修改文件：

- `/lib/api/base_url.dart` - 改用动态 getter
- `/lib/main.dart` - 添加 BaseUrlStore 初始化
- `/lib/router/system_routes.dart` - 添加路由配置
- `/lib/page/system/debug/system_debug_page.dart` - 添加菜单入口

## 代码规范遵循

- ✅ 使用单例模式管理全局状态
- ✅ 文件命名使用小写+下划线
- ✅ 类命名使用大驼峰
- ✅ 变量命名使用小驼峰
- ✅ 所有构造函数使用 `const` 和 `super.key`
- ✅ 使用 `final` 声明不可变变量
- ✅ Widget 构造函数使用命名可选参数
- ✅ 导入语句按字母顺序排列
- ✅ 使用 `dart format` 格式化代码
- ✅ 避免使用 `var`，明确指定类型

