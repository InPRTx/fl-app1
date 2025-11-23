import 'package:fl_app1/component/layout/simple_layout_with_menu_component.dart';
import 'package:fl_app1/page/system/debug/system_debug_base_url_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_jwt_token_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_view_timezone_page.dart';
import 'package:fl_app1/page/system/settings/system_local_time_page.dart';
import 'package:fl_app1/page/system/settings/system_settings_page.dart';
import 'package:go_router/go_router.dart';

final RouteBase SystemShellRoute = ShellRoute(
  builder: (context, state, child) {
    return SimpleLayoutWithMenuComponent(title: '首页菜单栏', child: child);
  },
  routes: [
    GoRoute(
      path: '/system/settings',
      name: 'system_settings',
      builder: (context, state) => const SystemSettingsPage(),
    ),
    GoRoute(
      path: '/system/settings/local_time',
      name: 'system_local_time',
      builder: (context, state) => const SystemLocalTimePage(),
    ),
    GoRoute(
      path: '/system/debug',
      name: 'system_debug',
      builder: (context, state) => const SystemDebugPage(),
    ),
    GoRoute(
      path: '/system/debug/view_timezone',
      name: 'system_debug_view_timezone',
      builder: (context, state) => const SystemDebugViewTimezonePage(),
    ),
    GoRoute(
      path: '/system/debug/base_url',
      name: 'system_debug_base_url',
      builder: (context, state) => const SystemDebugBaseUrlPage(),
    ),
    GoRoute(
      path: '/system/debug/jwt_token',
      name: 'system_debug_jwt_token',
      builder: (context, state) => const SystemDebugJwtTokenPage(),
    ),
  ],
);
