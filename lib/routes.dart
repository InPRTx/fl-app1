import 'package:flutter/material.dart';

import 'pages/auth/account_login/login_page.dart';
import 'pages/low_admin/user_v2.dart';
import 'version_page.dart';

/// 静态路由表（可在这里添加更多无法通过参数传递的静态页面）
final Map<String, WidgetBuilder> routes = {
  '/login': (c) => const LoginPage(),
  '/version': (c) => const VersionPage(),
};

/// 当通过 Navigator.of(context).pushNamed 跳转路由时，在 routes 查找不到时，会调用该方法
/// 保留对 `/low_admin/user_v2/<id>` 的特殊处理
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final name = settings.name ?? '';

  // Match /low_admin/user_v2/<id>
  const userV2Prefix = '/low_admin/user_v2/';
  if (name.startsWith(userV2Prefix)) {
    final idPart = name.substring(userV2Prefix.length);
    final id = int.tryParse(idPart);
    if (id != null) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => UserV2Page(userId: id),
      );
    }
  }

  // 如果静态路由表里有，直接走静态路由
  if (routes.containsKey(name)) {
    final builder = routes[name]!;
    return MaterialPageRoute(builder: (c) => builder(c), settings: settings);
  }

  // 否则返回 null 让 Flutter 处理未知路由（原来在 main.dart 中是返回 null）
  return null;
}
