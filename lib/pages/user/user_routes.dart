// filepath: lib/pages/user/user_routes.dart
import 'package:fl_app1/pages/user/dashboard.dart';
import 'package:fl_app1/widgets/user_layout.dart';
import 'package:go_router/go_router.dart';

/// User child routes extracted from `routes.dart` to keep that file smaller
/// and to centralize user route definitions under `lib/pages/user/`.
final RouteBase userShellRoute = ShellRoute(
  builder: (context, state, child) {
    return UserLayout(title: '用户中心', child: child);
  },
  routes: [
    GoRoute(
      path: '/user/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
