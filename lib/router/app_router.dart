import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/page/auth/login/auth_login_page.dart';
import 'package:fl_app1/page/auth/login/auth_simple_login_page.dart';
import 'package:fl_app1/page/debug/version/debug_version_page.dart';
import 'package:fl_app1/page/home_page.dart';
import 'package:fl_app1/page/low_admin/home/low_admin_home_page.dart';
import 'package:fl_app1/page/low_admin/old_service_shop_list/low_admin_old_service_shop_list_page.dart';
import 'package:fl_app1/page/low_admin/ss_node/low_admin_ss_node_page.dart';
import 'package:fl_app1/page/low_admin/ticket_detail/low_admin_ticket_detail_page.dart';
import 'package:fl_app1/page/low_admin/ticket_list/low_admin_ticket_list_page.dart';
import 'package:fl_app1/page/low_admin/user_bought_list/low_admin_user_bought_list_page.dart';
import 'package:fl_app1/page/low_admin/user_detail/low_admin_user_detail_page.dart';
import 'package:fl_app1/page/low_admin/user_pay_list/low_admin_user_pay_list_page.dart';
import 'package:fl_app1/page/low_admin/users_list/low_admin_users_list_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_base_url_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_jwt_token_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_page.dart';
import 'package:fl_app1/page/system/debug/system_debug_view_timezone_page.dart';
import 'package:fl_app1/page/system/settings/system_local_time_page.dart';
import 'package:fl_app1/page/system/settings/system_settings_page.dart';
import 'package:fl_app1/page/user/dashboard/user_dashboard_page.dart';
import 'package:fl_app1/router/low_admin_wrapper.dart';
import 'package:fl_app1/router/main_wrapper.dart';
import 'package:fl_app1/router/user_wrapper.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Main wrapper routes with simple layout
        AutoRoute(
          page: MainWrapperRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: MyHomeRoute.page,
              path: '',
            ),
            AutoRoute(
              page: DebugVersionRoute.page,
              path: 'version',
            ),
            AutoRoute(
              page: AuthLoginRoute.page,
              path: 'auth/login',
            ),
            AutoRoute(
              page: AuthSimpleLoginRoute.page,
              path: 'auth/simple_login',
            ),
            // System routes
            AutoRoute(
              page: SystemSettingsRoute.page,
              path: 'system/settings',
            ),
            AutoRoute(
              page: SystemLocalTimeRoute.page,
              path: 'system/settings/local_time',
            ),
            AutoRoute(
              page: SystemDebugRoute.page,
              path: 'system/debug',
            ),
            AutoRoute(
              page: SystemDebugViewTimezoneRoute.page,
              path: 'system/debug/view_timezone',
            ),
            AutoRoute(
              page: SystemDebugBaseUrlRoute.page,
              path: 'system/debug/base_url',
            ),
            AutoRoute(
              page: SystemDebugJwtTokenRoute.page,
              path: 'system/debug/jwt_token',
            ),
          ],
        ),

        // User wrapper routes
        AutoRoute(
          page: UserWrapperRoute.page,
          path: '/user',
          children: [
            AutoRoute(
              page: UserDashboardRoute.page,
              path: 'dashboard',
            ),
          ],
        ),

        // Low admin wrapper routes
        AutoRoute(
          page: LowAdminWrapperRoute.page,
          path: '/low_admin',
          children: [
            AutoRoute(
              page: LowAdminHomeRoute.page,
              path: '',
            ),
            AutoRoute(
              page: LowAdminUsersListRoute.page,
              path: 'users',
            ),
            AutoRoute(
              page: LowAdminUserBoughtListRoute.page,
              path: 'user_bought',
            ),
            AutoRoute(
              page: LowAdminUserPayListRoute.page,
              path: 'user_pay_list',
            ),
            AutoRoute(
              page: LowAdminOldServiceShopListRoute.page,
              path: 'old_service_shop',
            ),
            AutoRoute(
              page: LowAdminSsNodeRoute.page,
              path: 'ss_node',
            ),
            AutoRoute(
              page: LowAdminTicketListRoute.page,
              path: 'ticket',
            ),
            AutoRoute(
              page: LowAdminTicketDetailRoute.page,
              path: 'ticket/:id',
            ),
            AutoRoute(
              page: LowAdminUserDetailRoute.page,
              path: 'user_v2/:id',
            ),
          ],
        ),
      ];
}
