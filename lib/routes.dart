import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/auth/account_login/login_page.dart';
import 'pages/home_page.dart';
import 'pages/low_admin/low_admin_home.dart';
import 'pages/low_admin/low_admin_layout.dart';
import 'pages/low_admin/settings.dart';
import 'pages/low_admin/user_bought_list.dart';
import 'pages/low_admin/user_pay_list.dart';
import 'pages/low_admin/user_v2.dart';
import 'pages/low_admin/users_list.dart';
import 'pages/user/dashboard.dart';
import 'version_page.dart';

/// 使用 go_router 的路由器实例
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) =>
          const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/user/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/version',
      name: 'version',
      builder: (context, state) => const VersionPage(),
    ),

    // ShellRoute keeps the LowAdminLayout persistent while only the child changes
    ShellRoute(
      builder: (context, state, child) {
        // Determine selectedIndex based on current location
        final loc = state.uri.path;
        final selectedIndex = _selectedIndexForLocation(loc);
        return LowAdminLayout(
          title: '低权限管理后台',
          selectedIndex: selectedIndex,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/low_admin',
          name: 'low_admin',
          builder: (context, state) => const LowAdminHomePage(),
        ),
        GoRoute(
          path: '/low_admin/users',
          name: 'low_admin_users',
          builder: (context, state) => const UsersListPage(),
        ),
        GoRoute(
          path: '/low_admin/user_bought',
          name: 'low_admin_user_bought',
          builder: (context, state) => const UserBoughtListPage(),
        ),
        GoRoute(
          path: '/low_admin/user_pay_list',
          name: 'low_admin_user_pay_list',
          builder: (context, state) => const UserPayListPage(),
        ),
        GoRoute(
          path: '/low_admin/settings',
          name: 'low_admin_settings',
          builder: (context, state) => const LowAdminSettingsPage(),
        ),
      ],
    ),

    // Keep user detail as a separate route (full screen)
    GoRoute(
      path: '/low_admin/user_v2/:id',
      name: 'user_v2',
      builder: (context, state) {
        final idStr = state.pathParameters['id'];
        final id = int.tryParse(idStr?.toString() ?? '');
        if (id == null) {
          return const Scaffold(body: Center(child: Text('invalid id')));
        }
        return UserV2Page(userId: id);
      },
    ),
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
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '找不到页面',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              loc,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
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

int _selectedIndexForLocation(String location) {
  // Default to dashboard index 0
  if (location.startsWith('/low_admin/users')) return 1;
  if (location.startsWith('/low_admin/user_bought')) return 2;
  if (location.startsWith('/low_admin/user_pay_list')) return 3;
  if (location.startsWith('/low_admin/settings')) return 4;
  // exact /low_admin or others under low_admin default to 0
  return 0;
}
