import 'package:fl_app1/widgets/simple_layout_with_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/auth/account_login/login_page.dart';
import 'pages/home_page.dart';
import 'pages/low_admin/low_admin_routes.dart';
import 'pages/user/user_routes.dart';
import 'version_page.dart';

/// 使用 go_router 的路由器实例
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // Main app shell: show site navigation (menu/rail) for these routes
    ShellRoute(
      builder: (context, state, child) {
        return SimpleLayoutWithMenu(title: '首页菜单栏', child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) =>
              const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
        GoRoute(
          path: '/version',
          name: 'version',
          builder: (context, state) => const VersionPage(),
        ),
        // Put login inside the main shell so the menu is visible on login
        GoRoute(
          path: '/auth/login',
          name: 'auth_login',
          builder: (context, state) => const LoginPage(),
        ),
      ],
    ),

    // User shell route (moved to its own file)
    userShellRoute,

    // Low-admin packaged shell route
    lowAdminShellRoute,

    // Keep user detail as a separate route (full screen)
  ],
  errorBuilder: (context, state) {
    final loc = state.uri.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(state.error?.toString() ?? 'Error'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          tooltip: '返回',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('找不到页面', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              loc,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/');
              },
              icon: const Icon(Icons.home),
              label: const Text('回到主页'),
            ),
          ],
        ),
      ),
    );
  },
);
