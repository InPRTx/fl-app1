import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LowAdminHomePage extends StatelessWidget {
  const LowAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 1200;
        final bool isMedium = constraints.maxWidth >= 768;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '仪表盘',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '欢迎使用低权限管理后台',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 4 : (isMedium ? 2 : 1),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                delegate: SliverChildListDelegate([
                  _buildStatCard(
                    context: context,
                    icon: Icons.people,
                    title: '用户管理',
                    subtitle: '管理用户账号',
                    color: Colors.blue,
                    onTap: () => context.router.pushPath('/low_admin/users'),
                  ),
                  _buildStatCard(
                    context: context,
                    icon: Icons.shopping_bag,
                    title: '购买记录',
                    subtitle: '查看购买历史',
                    color: Colors.green,
                    onTap: () =>
                        context.router.pushPath('/low_admin/user_bought'),
                  ),
                  _buildStatCard(
                    context: context,
                    icon: Icons.account_balance_wallet,
                    title: '充值记录',
                    subtitle: '查看充值历史',
                    color: Colors.orange,
                    onTap: () =>
                        context.router.pushPath('/low_admin/user_pay_list'),
                  ),
                  _buildStatCard(
                    context: context,
                    icon: Icons.support_agent,
                    title: '工单管理',
                    subtitle: '处理用户工单',
                    color: Colors.purple,
                    onTap: () => context.router.pushPath('/low_admin/ticket'),
                  ),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      '快速操作',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 280,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildListDelegate([
                  _buildQuickActionCard(
                    context: context,
                    icon: Icons.person_search,
                    title: '查看用户详情',
                    description: '输入用户ID快速查看',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    ),
                    onTap: () => _showUserIdDialog(context),
                  ),
                  _buildQuickActionCard(
                    context: context,
                    icon: Icons.cloud,
                    title: '节点管理',
                    description: '管理SS/SSR节点',
                    gradient: const LinearGradient(
                      colors: [Color(0xFFf093fb), Color(0xFFF5576c)],
                    ),
                    onTap: () => context.router.pushPath('/low_admin/ss_node'),
                  ),
                  _buildQuickActionCard(
                    context: context,
                    icon: Icons.shopping_cart,
                    title: '旧版商品',
                    description: '管理旧版商品列表',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                    ),
                    onTap: () =>
                        context.router.pushPath('/low_admin/old_service_shop'),
                  ),
                  _buildQuickActionCard(
                    context: context,
                    icon: Icons.refresh,
                    title: '刷新数据',
                    description: '重新加载统计信息',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('数据已刷新')),
                      );
                    },
                  ),
                ]),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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

    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
        title: const Text('输入用户ID'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '用户ID',
            hintText: '例如: 123',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onSubmitted: (value) {
            final id = int.tryParse(value.trim());
            Navigator.pop(dialogContext, id);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              final id = int.tryParse(controller.text.trim());
              Navigator.pop(dialogContext, id);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result != null && context.mounted) {
      context.router.pushPath('/low_admin/user_v2/$result');
    } else if (result == null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入有效的用户ID'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
