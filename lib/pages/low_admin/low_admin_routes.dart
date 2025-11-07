import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'low_admin_home.dart';
import 'low_admin_layout.dart';
import 'settings.dart';
import 'user_bought_list.dart';
import 'user_pay_list.dart';
import 'user_v2.dart';
import 'users_list.dart';

/// Low admin child routes extracted from `routes.dart` to keep that file smaller
/// and to centralize low-admin route definitions under `lib/pages/low_admin/`.
final RouteBase lowAdminShellRoute = ShellRoute(
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
);

int _selectedIndexForLocation(String location) {
  // Default to dashboard index 0
  if (location.startsWith('/low_admin/users')) return 1;
  // Treat user detail pages as part of the Users section
  if (location.startsWith('/low_admin/user_v2')) return 1;
  if (location.startsWith('/low_admin/user_bought')) return 2;
  if (location.startsWith('/low_admin/user_pay_list')) return 3;
  if (location.startsWith('/low_admin/settings')) return 4;
  // exact /low_admin or others under low_admin default to 0
  return 0;
}
