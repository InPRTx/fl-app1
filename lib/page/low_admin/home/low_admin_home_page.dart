import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LowAdminHomePage extends StatelessWidget {
  const LowAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // The ShellRoute provides LowAdminLayout (menu). Return only the content.
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: 120,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 32),
            Text(
              '欢迎使用低权限管理后台',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '请从左侧菜单选择功能',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.people,
                  title: '用户管理',
                  description: '查看和编辑用户信息',
                  onTap: () => context.go('/low_admin/users'),
                ),
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.person_search,
                  title: '查看用户详情',
                  description: '输入用户ID查看详情',
                  onTap: () => _showUserIdDialog(context),
                ),
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.shopping_bag,
                  title: '购买记录',
                  description: '查看用户购买记录',
                  onTap: () => context.go('/low_admin/user_bought'),
                ),
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.account_balance_wallet,
                  title: '充值记录',
                  description: '查看用户充值记录',
                  onTap: () => context.go('/low_admin/user_pay_list'),
                ),
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.settings,
                  title: '系统设置',
                  description: '配置系统参数',
                  onTap: () => context.go('/low_admin/settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showUserIdDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final router = GoRouter.of(context);

    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('输入用户ID'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '用户ID',
            hintText: '例如: 123',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final id = int.tryParse(controller.text.trim());
              Navigator.pop(context, id);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result != null) {
      router.go('/low_admin/user_v2/$result');
    }
  }
}
