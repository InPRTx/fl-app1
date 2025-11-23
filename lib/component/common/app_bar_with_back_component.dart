import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 带返回按钮的 AppBar 组件
/// 确保在所有平台（包括 Web 刷新后）都能正确显示和处理返回按钮
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
          // 使用 canPop 检查是否可以返回
          // 这在 Web 平台刷新后也能正确工作
          if (context.canPop()) {
            context.pop();
          } else if (fallbackRoute != null) {
            // 如果有 fallback 路由，导航到该路由
            context.go(fallbackRoute!);
          } else {
            // 默认返回首页
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
