import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimpleLayoutWithMenu extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const SimpleLayoutWithMenu({
    super.key,
    required this.child,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= 768;

        return Scaffold(
          appBar: AppBar(
            title: Text(title ?? '首页'),
            backgroundColor: theme.colorScheme.inversePrimary,
            actions: actions,
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
          drawer: isLargeScreen ? null : const SimpleNavigationDrawer(),
          body: Row(
            children: [
              if (isLargeScreen) const SimpleNavigationRail(),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

// NavigationRail for large screens
class SimpleNavigationRail extends StatelessWidget {
  const SimpleNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(currentPath);

    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        final route = _getRouteByIndex(index);
        if (route != null) {
          context.go(route);
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: _allMenuItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          label: Text(item.label),
        );
      }).toList(),
    );
  }

  int _getSelectedIndex(String currentPath) {
    for (int i = 0; i < _allMenuItems.length; i++) {
      final route = _allMenuItems[i].route;
      if (route == currentPath) return i;
      if (route != null && route != '/' && currentPath.startsWith(route)) {
        return i;
      }
    }
    return 0;
  }

  String? _getRouteByIndex(int index) {
    if (index >= 0 && index < _allMenuItems.length) {
      return _allMenuItems[index].route;
    }
    return null;
  }
}

// NavigationDrawer for small screens
class SimpleNavigationDrawer extends StatelessWidget {
  const SimpleNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(currentPath);

    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        final route = _getRouteByIndex(index);
        if (route != null) {
          context.go(route);
          if (Scaffold.of(context).hasDrawer) {
            Navigator.of(context).pop();
          }
        }
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            '导航菜单',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        ..._mainMenuItems.map((item) {
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
        ..._otherMenuItems.map((item) {
          return NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.label),
          );
        }),
      ],
    );
  }

  int _getSelectedIndex(String currentPath) {
    for (int i = 0; i < _allMenuItems.length; i++) {
      final route = _allMenuItems[i].route;
      if (route == currentPath) return i;
      if (route != null && route != '/' && currentPath.startsWith(route)) {
        return i;
      }
    }
    return 0;
  }

  String? _getRouteByIndex(int index) {
    if (index >= 0 && index < _allMenuItems.length) {
      return _allMenuItems[index].route;
    }
    return null;
  }
}

// Menu items
class _MenuItem {
  final IconData icon;
  final String label;
  final String? route;

  _MenuItem({required this.icon, required this.label, this.route});
}

final List<_MenuItem> _mainMenuItems = [
  _MenuItem(icon: Icons.home, label: '首页', route: '/'),
  _MenuItem(
    icon: Icons.support_agent_outlined,
    label: '技术支持',
    route: '/user/tickets',
  ),
];

final List<_MenuItem> _otherMenuItems = [
  _MenuItem(icon: Icons.settings_outlined, label: '设置', route: '/settings'),
  _MenuItem(icon: Icons.info_outline, label: '关于', route: '/about'),
];

final List<_MenuItem> _allMenuItems = [..._mainMenuItems, ..._otherMenuItems];
