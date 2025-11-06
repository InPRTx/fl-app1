import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'user_menu.dart';


class UserNavigationRail extends StatefulWidget {
  const UserNavigationRail({super.key});

  @override
  State<UserNavigationRail> createState() => _UserNavigationRailState();
}

class _UserNavigationRailState extends State<UserNavigationRail> {
  OverlayEntry? _overlayEntry;

  int _getSelectedIndex(String currentPath) {
    // 查找完全匹配的路由
    for (int i = 0; i < userNavItems.length; i++) {
      final item = userNavItems[i];
      if (item.route == currentPath) {
        return i;
      }
    }

    // 查找路径前缀匹配（用于子页面）
    for (int i = 0; i < userNavItems.length; i++) {
      final item = userNavItems[i];
      if (item.route != null && currentPath.startsWith(item.route!)) {
        return i;
      }
    }

    return 0;
  }

  List<SidebarItemMenu>? _getSubmenuItems(int index) {
    final itemRoutes = [
      '/user/dashboard',
      '/user/services/',
      '/user/wallet/billing',
      '/user/tickets',
      '/user/subscribe-log',
      '/user/my-account',
      '/user/promote',
      '/settings',
    ];

    if (index >= itemRoutes.length) return null;
    final route = itemRoutes[index];

    // 查找对应的 sidebarItemLogin 项目
    for (final item in sidebarItemLogin) {
      if (item.to == route && item.children != null &&
          item.children!.isNotEmpty) {
        return item.children;
      }
      if (item.children != null) {
        for (final child in item.children!) {
          if (child.to == route) {
            return item.children;
          }
        }
      }
    }
    return null;
  }

  void _showSubmenu(BuildContext context, int index, Offset buttonPosition) {
    final submenuItems = _getSubmenuItems(index);
    if (submenuItems == null || submenuItems.isEmpty) return;

    _removeOverlay();

    // 在创建 Overlay 前获取当前路径和主题，避免在 Overlay context 中访问
    final currentPath = GoRouterState
        .of(context)
        .uri
        .path;
    final theme = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) =>
          Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _removeOverlay,
                  child: Container(color: Colors.transparent),
                ),
              ),
              Positioned(
                left: buttonPosition.dx + 80,
                top: buttonPosition.dy,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 200,
                      maxWidth: 280,
                      maxHeight: 400,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: submenuItems.map((item) {
                        final isSelected = currentPath == item.to;
                        return ListTile(
                          leading: item.icon != null
                              ? Icon(
                            item.icon,
                            size: 20,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface,
                          )
                              : null,
                          title: Text(
                            item.title ?? '',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          selected: isSelected,
                          selectedTileColor:
                          theme.colorScheme.primaryContainer.withValues(
                              alpha: 0.3),
                          dense: true,
                          onTap: item.to != null
                              ? () {
                            _removeOverlay();
                            context.go(item.to!);
                          }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState
        .of(context)
        .uri
        .path;
    final selectedIndex = _getSelectedIndex(currentPath);

    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              Icons.account_circle,
              size: 48,
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userNavItems.length,
              itemBuilder: (context, index) {
                final item = userNavItems[index];
                final isSelected = selectedIndex == index;
                final hasSubmenu = _getSubmenuItems(index) != null;

                return MouseRegion(
                  onEnter: (_) {},
                  onExit: (_) {},
                  child: Builder(
                    builder: (itemContext) {
                      return InkWell(
                        onTap: () {
                          if (hasSubmenu) {
                            final RenderBox? renderBox =
                            itemContext.findRenderObject() as RenderBox?;
                            if (renderBox != null) {
                              final position = renderBox.localToGlobal(
                                  Offset.zero);
                              _showSubmenu(
                                context,
                                index,
                                position,
                              );
                            }
                          } else if (item.route != null) {
                            context.go(item.route!);
                          }
                        },
                        child: Container(
                      height: 72,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      color: isSelected
                          ? Theme
                          .of(context)
                          .colorScheme
                          .secondaryContainer
                          .withValues(alpha: 0.5)
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                item.icon,
                                color: isSelected
                                    ? Theme
                                    .of(context)
                                    .colorScheme
                                    .primary
                                    : Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              if (hasSubmenu)
                                Positioned(
                                  right: -8,
                                  top: -4,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 16,
                                    color: isSelected
                                        ? Theme
                                        .of(context)
                                        .colorScheme
                                        .primary
                                        : Theme
                                        .of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                              color: isSelected
                                  ? Theme
                                  .of(context)
                                  .colorScheme
                                  .primary
                                  : Theme
                                  .of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: IconButton(
              icon: const Icon(Icons.home),
              tooltip: '返回主页',
              onPressed: () {
                context.go('/');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserSidebar extends StatefulWidget {
  const UserSidebar({super.key});

  @override
  State<UserSidebar> createState() => _UserSidebarState();
}

class _UserSidebarState extends State<UserSidebar> {
  final Map<int, bool> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 48,
                  color: theme.colorScheme.onPrimary,
                ),
                const SizedBox(height: 8),
                Text(
                  '用户中心',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...sidebarItemLogin.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _buildMenuItem(context, item, index, currentPath);
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('返回主页'),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    SidebarItemMenu item,
    int index,
    String currentPath,
  ) {
    final theme = Theme.of(context);

    if (item.header != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(
          item.header!,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (item.divider) {
      return const Divider();
    }

    if (item.children != null && item.children!.isNotEmpty) {
      final isExpanded = _expandedItems[index] ?? false;

      return Column(
        children: [
          ListTile(
            leading: item.icon != null
                ? Icon(item.icon, color: theme.colorScheme.onSurface)
                : null,
            title: Text(item.title ?? ''),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: theme.colorScheme.onSurface,
            ),
            enabled: !item.disabled,
            onTap: () {
              setState(() {
                _expandedItems[index] = !isExpanded;
              });
            },
          ),
          if (isExpanded)
            ...item.children!.map((child) {
              final isSelected = currentPath == child.to;
              return ListTile(
                leading: child.icon != null
                    ? Icon(
                        child.icon,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                      )
                    : null,
                title: Text(child.title ?? ''),
                contentPadding: const EdgeInsets.only(left: 72, right: 16),
                selected: isSelected,
                selectedTileColor: theme.colorScheme.primaryContainer,
                enabled: !child.disabled,
                onTap: child.to != null
                    ? () {
                        Navigator.pop(context);
                        context.go(child.to!);
                      }
                    : null,
              );
            }),
        ],
      );
    }

    final isSelected = currentPath == item.to;

    return ListTile(
      leading: item.icon != null
          ? Icon(
              item.icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            )
          : null,
      title: Text(item.title ?? ''),
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primaryContainer,
      enabled: !item.disabled,
      trailing: item.chip != null
          ? Chip(label: Text(item.chip!), backgroundColor: item.chipColor)
          : null,
      onTap: item.to != null
          ? () {
              Navigator.pop(context);
              context.go(item.to!);
            }
          : null,
    );
  }
}
