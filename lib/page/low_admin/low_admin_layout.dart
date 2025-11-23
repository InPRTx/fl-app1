import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LowAdminLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final int selectedIndex;
  final ValueChanged<int>? onNavigationChanged;

  const LowAdminLayout({
    super.key,
    required this.child,
    required this.title,
    required this.selectedIndex,
    this.onNavigationChanged,
  });

  @override
  State<LowAdminLayout> createState() => _LowAdminLayoutState();
}

class _LowAdminLayoutState extends State<LowAdminLayout> {
  final List<NavigationItem> _navItems = [
    NavigationItem(
      icon: Icons.dashboard,
      label: '仪表盘',
      path: '/low_admin',
    ),
    NavigationItem(
      icon: Icons.people,
      label: '用户管理',
      path: '/low_admin/users',
    ),
    NavigationItem(
      icon: Icons.shopping_bag,
      label: '购买记录',
      path: '/low_admin/user_bought',
    ),
    NavigationItem(
      icon: Icons.account_balance_wallet,
      label: '充值记录',
      path: '/low_admin/user_pay_list',
    ),
    NavigationItem(
      icon: Icons.shopping_cart,
      label: '旧版商品',
      path: '/low_admin/old_service_shop',
    ),
    NavigationItem(
      icon: Icons.cloud,
      label: '节点管理',
      path: '/low_admin/ss_node',
    ),
    NavigationItem(
      icon: Icons.support_agent,
      label: '工单管理',
      path: '/low_admin/ticket',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= 768;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            leading: isLargeScreen
                ? null
                : Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
          ),
          drawer: isLargeScreen ? null : _buildDrawer(context),
          body: Row(
            children: [
              if (isLargeScreen) _buildNavigationRail(),
              Expanded(child: widget.child),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.admin_panel_settings,
                  size: 48,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 8),
                Text(
                  '管理后台',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ..._navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              selected: widget.selectedIndex == index,
              onTap: () {
                Navigator.pop(context);
                // 使用回调来切换标签
                widget.onNavigationChanged?.call(index);
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('返回主页'),
            onTap: () {
              Navigator.pop(context);
              context.router.pushPath('/');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (index) {
        // 使用回调来切换标签
        widget.onNavigationChanged?.call(index);
      },
      labelType: NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Icon(
          Icons.admin_panel_settings,
          size: 48,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      destinations: _navItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          label: Text(item.label),
        );
      }).toList(),
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: IconButton(
              icon: const Icon(Icons.home),
              tooltip: '返回主页',
              onPressed: () {
                context.router.pushPath('/');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  NavigationItem({
    required this.icon,
    required this.label,
    required this.path,
  });

  final IconData icon;
  final String label;
  final String path;
}
