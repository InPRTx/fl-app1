import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/page/low_admin/low_admin_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LowAdminWrapperPage extends StatefulWidget {
  const LowAdminWrapperPage({super.key});

  @override
  State<LowAdminWrapperPage> createState() => _LowAdminWrapperPageState();
}

class _LowAdminWrapperPageState extends State<LowAdminWrapperPage> {
  int _selectedIndexForLocation(String location) {
    // Default to dashboard index 0
    if (location.startsWith('/low_admin/users')) return 1;
    // Treat user detail pages as part of the Users section
    if (location.startsWith('/low_admin/user_v2')) return 1;
    if (location.startsWith('/low_admin/user_bought')) return 2;
    if (location.startsWith('/low_admin/user_pay_list')) return 3;
    if (location.startsWith('/low_admin/old_service_shop')) return 4;
    if (location.startsWith('/low_admin/ss_node')) return 5;
    // Treat ticket detail pages as part of the Ticket section
    if (location.startsWith('/low_admin/ticket')) return 6;
    // exact /low_admin or others under low_admin default to 0
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // 在 build 方法中获取最新的路由状态
    // StatefulWidget 会在路由变化时重新构建
    final router = context.watchRouter;
    final currentPath = router.currentPath;
    final selectedIndex = _selectedIndexForLocation(currentPath);

    return LowAdminLayout(
      title: '低权限管理后台',
      selectedIndex: selectedIndex,
      child: const AutoRouter(),
    );
  }
}
