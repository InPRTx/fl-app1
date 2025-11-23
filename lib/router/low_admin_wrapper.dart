import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/page/low_admin/low_admin_layout.dart';
import 'package:fl_app1/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LowAdminWrapperPage extends StatelessWidget {
  const LowAdminWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        LowAdminHomeRoute(),
        LowAdminUsersListRoute(),
        LowAdminUserBoughtListRoute(),
        LowAdminUserPayListRoute(),
        LowAdminOldServiceShopListRoute(),
        LowAdminSsNodeRoute(),
        LowAdminTicketListRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return LowAdminLayout(
          title: '低权限管理后台',
          selectedIndex: tabsRouter.activeIndex,
          onNavigationChanged: (index) {
            tabsRouter.setActiveIndex(index);
          },
          child: child,
        );
      },
    );
  }
}
