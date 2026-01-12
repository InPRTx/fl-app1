# 修复 SS 节点页面类型错误

## 问题描述

在 `lib/page/low_admin/ss_node/low_admin_ss_node_page.dart` 文件中，编译时出现类型不匹配错误：

```
Error: The argument type 'Map<String, WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict>' can't be assigned to the parameter type 'Map<String, WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict>'.
```

## 问题原因

代码中使用的类型别名混淆了**输出类型**（从 API 读取的 `SsNode`）和**输入类型**（提交到 API 的 `SsNodePydantic`）。

原来的类型别名：

```dart
typedef UserGroupHostDict = WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict;
typedef UserGroupHost = WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHost;
```

这导致在 `_parseUserGroupHost` 方法中创建的 Map 使用了错误的值类型（`SsNode` 版本的 Dict），但需要的是 `SsNodePydantic` 版本的
Dict。

## 解决方案

### 1. 添加正确的类型别名

区分输入和输出类型：

```dart
// 用于读取的类型（从API获取）
typedef UserGroupHostDictOutput = WebSubFastapiModelsDatabaseModelTableSsNodeSsNodeUserGroupHostSsNodeUserGroupHostDict;
typedef UserGroupHostOutput = WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHost;

// 用于提交的类型（提交到API）
typedef UserGroupHostDictInput = WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHostSsNodeUserGroupHostDict;
typedef UserGroupHostInput = WebSubFastapiModelsDatabaseModelTableSsNodePydanticSsNodePydanticUserGroupHost;
```

### 2. 添加必要的导入

由于 `export.dart` 中没有导出 `UserGroupHostDictInput` 类型，需要直接导入：

```dart
import 'package:fl_app1/api/models/web_sub_fastapi_models_database_model_table_ss_node_pydantic_ss_node_pydantic_user_group_host_ss_node_user_group_host_dict.dart';
```

### 3. 更新相关方法

修复 `_parseUserGroupHost` 方法和 `_handleSubmit` 方法中的类型声明：

```dart
UserGroupHostInput _parseUserGroupHost(String raw) {
  final dynamic decoded = jsonDecode(raw);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('必须是对象结构');
  }

  final Map<String, UserGroupHostDictInput> map = decoded.map((key, value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('每个用户组必须是对象');
    }
    return MapEntry(
      key,
      UserGroupHostDictInput.fromJson(value),
    );
  });
  return UserGroupHostInput(
    userGroupHost: map,
  );
}
```

## 验证

构建成功：

```bash
flutter build macos --debug
✓ Built build/macos/Build/Products/Debug/fl-app1.app
```

## 技术要点

1. **API 自动生成代码**：`/lib/api` 下的代码是自动生成的，不能修改
2. **类型系统**：区分输入（Input/Pydantic）和输出（Output/普通）类型
3. **类型别名**：使用类型别名简化超长的类名，提高代码可读性
4. **直接导入**：当 `export.dart` 没有导出某个类时，需要直接导入完整路径

## 修改的文件

- `/Users/inprtx/git/hub/InPRTx/fl-app1/lib/page/low_admin/ss_node/low_admin_ss_node_page.dart`

## 日期

2026-01-12

