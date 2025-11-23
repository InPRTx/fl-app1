import 'package:fl_app1/component/layout/user_layout_component.dart';
import 'package:fl_app1/page/user/dashboard/user_dashboard_page.dart';
import 'package:go_router/go_router.dart';

/// User child routes extracted from `routes.dart` to keep that file smaller
/// and to centralize user route definitions under `lib/page/user/`.
final RouteBase userShellRoute = ShellRoute(
  builder: (context, state, child) {
    return UserLayoutComponent(title: '用户中心', child: child);
  },
  routes: [
    GoRoute(
      path: '/user/dashboard',
      name: 'dashboard',
      builder: (context, state) => const UserDashboardPage(),
    ),
  ],
);
