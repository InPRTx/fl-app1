import 'package:flutter/material.dart';

import 'user_sidebar_component.dart';

class UserLayoutComponent extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const UserLayoutComponent({
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
            title: Text(title ?? '用户中心'),
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
          drawer: isLargeScreen ? null : const UserSidebarComponent(),
          body: Row(
            children: [
              if (isLargeScreen) const UserNavigationRailComponent(),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
