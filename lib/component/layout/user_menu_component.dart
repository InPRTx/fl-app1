// filepath: lib/widgets/user_menu.dart
import 'package:flutter/material.dart';

// Extracted menu data and navigation items for the user section.
// This was previously defined inside `user_sidebar.dart`.

class SidebarItemMenu {
  final String? header;
  final String? title;
  final IconData? icon;
  final String? to;
  final bool divider;
  final String? chip;
  final Color? chipColor;
  final String? chipVariant;
  final IconData? chipIcon;
  final List<SidebarItemMenu>? children;
  final bool disabled;
  final String? type;
  final String? subCaption;

  const SidebarItemMenu({
    this.header,
    this.title,
    this.icon,
    this.to,
    this.divider = false,
    this.chip,
    this.chipColor,
    this.chipVariant,
    this.chipIcon,
    this.children,
    this.disabled = false,
    this.type,
    this.subCaption,
  });
}

final List<SidebarItemMenu> sidebarItemLogin = [
  const SidebarItemMenu(header: '用户中心'),
  const SidebarItemMenu(
    title: '主页',
    icon: Icons.account_circle,
    to: '/user/dashboard',
  ),
  const SidebarItemMenu(
    title: '产品服务',
    icon: Icons.shopping_bag_outlined,
    children: [
      SidebarItemMenu(
        title: '我的服务',
        icon: Icons.layers_outlined,
        to: '/user/services/',
      ),
      SidebarItemMenu(
        title: '商品购买记录（旧版）',
        icon: Icons.inventory_2_outlined,
        to: '/user/wallet/purchase-records-old',
      ),
      SidebarItemMenu(
        title: '续费服务',
        icon: Icons.send_outlined,
        to: '/user/services/renewals/',
      ),
      SidebarItemMenu(
        title: '购买服务',
        icon: Icons.shopping_cart_outlined,
        to: '/user/services/buy/',
      ),
      SidebarItemMenu(
        title: '购买服务（旧版）',
        icon: Icons.add_shopping_cart_outlined,
        to: '/user/shop-old/',
      ),
      SidebarItemMenu(
        title: '附加服务',
        icon: Icons.add_box_outlined,
        to: '/user/services/addons/',
      ),
    ],
  ),
  const SidebarItemMenu(
    title: '财务管理',
    icon: Icons.attach_money,
    children: [
      SidebarItemMenu(
        title: '我的账单',
        icon: Icons.receipt_long_outlined,
        to: '/user/wallet/billing',
      ),
      SidebarItemMenu(
        title: '我的充值',
        icon: Icons.account_balance_wallet_outlined,
        to: '/user/wallet/recharge',
      ),
      SidebarItemMenu(
        title: '账户充值',
        icon: Icons.add_card_outlined,
        to: '/user/wallet/recharge/new',
      ),
      SidebarItemMenu(
        title: '兑换码',
        icon: Icons.qr_code_scanner_outlined,
        to: '/user/wallet/recharge/cd-key',
      ),
    ],
  ),
  const SidebarItemMenu(
    title: '技术支持',
    icon: Icons.support_agent_outlined,
    children: [
      SidebarItemMenu(
        title: '节点列表',
        icon: Icons.router_outlined,
        to: '/user/nodes',
      ),
      SidebarItemMenu(
        title: '重置连接信息',
        icon: Icons.settings_backup_restore_outlined,
        to: '/user/connection-reset',
      ),
      SidebarItemMenu(
        title: '我的工单',
        icon: Icons.confirmation_number_outlined,
        to: '/user/tickets',
      ),
      SidebarItemMenu(
        title: '公告信息',
        icon: Icons.campaign_outlined,
        to: '/user/announcements',
      ),
      SidebarItemMenu(
        title: '知识库',
        icon: Icons.menu_book_outlined,
        to: '/user/help',
      ),
    ],
  ),
  const SidebarItemMenu(
    title: '服务使用',
    icon: Icons.cloud_upload_outlined,
    children: [
      SidebarItemMenu(
        title: '流量使用情况',
        icon: Icons.donut_small_outlined,
        to: '/user/subscribe-log',
      ),
      SidebarItemMenu(
        title: '共享账户',
        icon: Icons.people_outline,
        to: '/user/share-accounts',
      ),
      SidebarItemMenu(
        title: '审计规则',
        icon: Icons.rule_outlined,
        to: '/user/audit',
      ),
      SidebarItemMenu(
        title: '审计记录',
        icon: Icons.history_outlined,
        to: '/user/audit/view',
      ),
    ],
  ),
  const SidebarItemMenu(
    title: '我的账户',
    icon: Icons.person_outline,
    to: '/user/my-account',
  ),
  const SidebarItemMenu(
    title: '提交工单',
    icon: Icons.add_task_outlined,
    to: '/user/tickets/new',
  ),
  const SidebarItemMenu(
    title: '用户推广',
    icon: Icons.share_outlined,
    to: '/user/promote',
  ),
  const SidebarItemMenu(header: '其他设置'),
  const SidebarItemMenu(
    title: '设置',
    icon: Icons.settings_outlined,
    to: '/settings',
  ),
  const SidebarItemMenu(title: '关于我们', icon: Icons.info_outline, to: '/about'),
];

// 主要导航项从 sidebarItemLogin 计算而来，避免重复定义
List<UserNavigationItem> get userNavItems {
  final List<UserNavigationItem> items = [];
  for (final item in sidebarItemLogin) {
    if (item.header != null) continue;
    if (item.divider) continue;
    // Only include top-level items (title present)
    if (item.title != null) {
      items.add(
        UserNavigationItem(
          icon: item.icon ?? Icons.circle,
          label: item.title!,
          route: item.to,
        ),
      );
    }
  }
  return items;
}

class UserNavigationItem {
  final IconData icon;
  final String label;
  final String? route;

  UserNavigationItem({required this.icon, required this.label, this.route});
}
