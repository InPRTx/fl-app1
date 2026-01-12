# 修复 WASM 编译失败问题

## 问题描述

执行 `flutter build web --release --wasm` 时出现编译错误：

```
Target dart2wasm failed: ProcessException: Process exited abnormally with exit code 254:
flutter_secure_storage_web-1.2.1/lib/flutter_secure_storage_web.dart:5:8: Error: Dart library 'dart:html' is not available on this platform.
import 'dart:html' as html;

JS interop library 'dart:js_util' can't be imported when compiling to Wasm.
Try using 'dart:js_interop' or 'dart:js_interop_unsafe' instead.
```

## 问题原因

`flutter_secure_storage_web` 包依赖了不兼容 WASM 的库：

- `dart:html` - 在 WASM 平台不可用
- `dart:js_util` - 已废弃，需要使用 `dart:js_interop` 替代
- `package:js/js.dart` - 不支持 WASM

## 解决方案

### 1. 移除不兼容的依赖

由于项目中实际使用的是 `shared_preferences` 进行数据存储（在 `auth_store.dart`、`base_url_store.dart`、
`local_time_store.dart` 中），`flutter_secure_storage` 并未被实际使用，因此直接移除该依赖。

**修改文件：** `pubspec.yaml`

移除以下行：

```yaml
flutter_secure_storage: ^9.2.2
```

### 2. 更新依赖

```bash
flutter pub get
```

自动移除的相关包：

- flutter_secure_storage 9.2.4
- flutter_secure_storage_linux 1.2.3
- flutter_secure_storage_macos 3.1.3
- flutter_secure_storage_platform_interface 1.1.2
- flutter_secure_storage_web 1.2.1
- flutter_secure_storage_windows 3.1.2
- js 0.6.7

### 3. 清理构建缓存

```bash
flutter clean
```

### 4. 重新构建 WASM

```bash
flutter build web --release --wasm
```

## 构建结果

✅ 编译成功！

```
Font asset "CupertinoIcons.ttf" was tree-shaken, reducing it from 257628 to 1472 bytes (99.4% reduction).
Font asset "MaterialIcons-Regular.otf" was tree-shaken, reducing it from 1645184 to 22676 bytes (98.6% reduction).
Compiling lib/main.dart for the Web...                             29.1s
✓ Built build/web
```

## 存储方案说明

当前项目使用 `shared_preferences` 进行数据持久化存储，已满足需求：

### 使用位置

1. **AuthStore** (`lib/store/service/auth/auth_store.dart`)
    - 存储 refreshToken（刷新令牌）
    - 自动刷新访问令牌机制

2. **BaseUrlStore** (`lib/store/base_url_store.dart`)
    - 存储 API 基础 URL 配置

3. **LocalTimeStore** (`lib/store/local_time_store.dart`)
    - 存储本地时间相关配置

### SharedPreferences vs FlutterSecureStorage

| 特性      | SharedPreferences | FlutterSecureStorage |
|---------|-------------------|----------------------|
| WASM 支持 | ✅ 完全支持            | ❌ 不支持                |
| 平台兼容性   | ✅ 全平台             | ⚠️ Web 平台限制          |
| 加密存储    | ❌ 明文存储            | ✅ 加密存储               |
| 性能      | ✅ 快速              | ⚠️ 较慢                |
| 适用场景    | 一般配置、非敏感数据        | 敏感信息（密码、令牌）          |

## 注意事项

1. **安全性考虑**
    - `shared_preferences` 在 Web 平台使用 `localStorage`，数据未加密
    - 不要存储高度敏感的用户信息（如明文密码）
    - JWT 令牌本身已包含签名验证机制，存储在 localStorage 可接受

2. **WASM 兼容性**
    - 使用支持 WASM 的包：`package:web` 替代 `dart:html`
    - 使用 `dart:js_interop` 替代 `dart:js_util`
    - 避免使用已废弃的 `package:js`

3. **最佳实践**
    - 定期检查依赖的 WASM 兼容性
    - 优先选择官方推荐的现代化包
    - 关注 Flutter WASM 支持进展：https://flutter.dev/to/wasm

## 相关文件

- `pubspec.yaml` - 依赖配置
- `lib/store/service/auth/auth_store.dart` - 认证状态管理
- `lib/store/base_url_store.dart` - URL 配置管理
- `lib/store/local_time_store.dart` - 时间配置管理

## 参考资料

- [Flutter WASM 官方文档](https://flutter.dev/to/wasm)
- [Dart JS Interop 指南](https://dart.dev/web/js-interop)
- [SharedPreferences 文档](https://pub.dev/packages/shared_preferences)

