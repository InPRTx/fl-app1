import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/auth/account_login/login_page.dart';
import 'pages/home_page.dart';
import 'pages/low_admin/low_admin_home.dart';
import 'pages/low_admin/settings.dart';
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
      path: '/low_admin/settings',
      name: 'low_admin_settings',
      builder: (context, state) => const LowAdminSettingsPage(),
    ),
    GoRoute(
      path: '/low_admin/user_v2/:id',
      name: 'user_v2',
      builder: (context, state) {
        // Use typed access to avoid dynamic invocation of a missing `params` on some go_router versions
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
