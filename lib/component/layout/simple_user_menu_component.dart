import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SimpleUserMenu extends StatelessWidget {
  const SimpleUserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = context.router.currentPath;

    return NavigationDrawer(
      selectedIndex: _getSelectedIndex(currentPath),
      onDestinationSelected: (index) {
        final route = _menuItems[index].route;
        if (route != null) {
          context.router.pushNamed(route);
          if (Scaffold.of(context).hasDrawer) {
            Navigator.of(context).pop();
          }
        }
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            '用户中心',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        ..._menuItems.map((item) {
          return NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.label),
          );
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text(
            '其他',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        ..._otherItems.map((item) {
          return NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.label),
          );
        }),
      ],
    );
  }

  int _getSelectedIndex(String currentPath) {
    final allItems = [..._menuItems, ..._otherItems];
    for (int i = 0; i < allItems.length; i++) {
      final route = allItems[i].route;
      if (route == currentPath) return i;
      if (route != null && currentPath.startsWith(route)) return i;
    }
    return 0;
  }

  static final List<_MenuItem> _menuItems = [
    _MenuItem(icon: Icons.home, label: '首页', route: '/'),
    _MenuItem(icon: Icons.dashboard, label: '用户首页', route: '/user/dashboard'),
    _MenuItem(
      icon: Icons.support_agent_outlined,
      label: '技术支持',
      route: '/user/tickets',
    ),
    _MenuItem(
      icon: Icons.person_outline,
      label: '我的账户',
      route: '/user/my-account',
    ),
  ];

  static final List<_MenuItem> _otherItems = [
    _MenuItem(icon: Icons.settings_outlined,
        label: '设置',
        route: '/system/settings'),
    _MenuItem(icon: Icons.info_outline, label: '关于', route: '/about'),
  ];
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String? route;

  _MenuItem({required this.icon, required this.label, this.route});
}
