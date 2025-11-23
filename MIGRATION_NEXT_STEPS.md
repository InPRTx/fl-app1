# Auto Route 迁移 - 下一步操作指南

## ✅ 已完成的工作

所有代码迁移工作已经完成！从 `go_router` 到 `auto_route` 的完整迁移包括：

1. ✅ 更新了 37 个文件
2. ✅ 添加了 `@RoutePage()` 注解到 19 个页面
3. ✅ 创建了新的路由架构
4. ✅ 更新了所有导航调用
5. ✅ 创建了完整的迁移文档

## ⚠️ 重要：需要您执行的步骤

代码已经准备就绪，但还需要以下步骤才能让应用运行：

### 1. 安装依赖
```bash
flutter pub get
```

### 2. 生成路由代码（必须！）
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

这个命令会生成 `lib/router/app_router.gr.dart` 文件，这个文件是必需的。

### 3. 验证生成结果
检查 `lib/router/app_router.gr.dart` 文件是否已生成。

### 4. 运行应用
```bash
flutter run
```

## 📋 测试清单

运行应用后，请测试以下功能：

- [ ] 主页显示正常
- [ ] 登录页面可以访问 (`/auth/login`)
- [ ] 用户仪表板可以访问 (`/user/dashboard`)
- [ ] 低权限管理页面可以访问 (`/low_admin`)
- [ ] 用户详情页面（带参数）正常工作 (`/low_admin/user_v2/:id`)
- [ ] 购买记录页面（带查询参数）正常工作 (`/low_admin/user_bought?q=user_id:123`)
- [ ] 返回按钮正常工作
- [ ] 侧边栏导航正常工作

## 🐛 如果遇到问题

### 问题1: 找不到生成的文件
**症状**: 编译错误，提示找不到 `app_router.gr.dart`

**解决方案**:
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 问题2: 路由不工作
**症状**: 点击导航没有反应或报错

**检查**:
1. 确认生成的 `app_router.gr.dart` 文件存在
2. 确认所有页面都有 `@RoutePage()` 注解
3. 检查路由路径是否正确

### 问题3: 编译错误
**症状**: Dart 分析器报错

**解决方案**:
1. 运行 `flutter clean`
2. 运行 `flutter pub get`
3. 重新生成路由代码
4. 重启 IDE

## 📚 参考文档

详细的迁移文档位于：
```
docs_ai/2025_11/23_go_router_to_auto_route.md
```

## 🔄 如果需要回滚

如果迁移出现问题，可以回滚到之前的 `go_router` 版本：

```bash
# 恢复备份文件
mv lib/router/index.dart.bak lib/router/index.dart
mv lib/router/user_routes.dart.bak lib/router/user_routes.dart
mv lib/router/low_admin_routes.dart.bak lib/router/low_admin_routes.dart
mv lib/router/system_routes.dart.bak lib/router/system_routes.dart

# 然后通过 git 恢复其他文件
git checkout HEAD~2 pubspec.yaml
git checkout HEAD~2 lib/main.dart
# ... 等等
```

## ✨ 迁移完成后

一切正常后，可以删除备份文件：
```bash
rm lib/router/*.bak
```

## 💡 添加新页面的步骤

将来添加新页面时，请遵循以下步骤：

1. 创建页面文件
2. 添加 `@RoutePage()` 注解到页面类
3. 在 `lib/router/app_router.dart` 中添加路由
4. 运行 `flutter pub run build_runner build --delete-conflicting-outputs`
5. 使用 `context.router.pushNamed('/path')` 进行导航

---

**如有任何问题，请查看 `docs_ai/2025_11/23_go_router_to_auto_route.md` 获取完整文档。**
