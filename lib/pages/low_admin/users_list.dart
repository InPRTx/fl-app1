import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'low_admin_layout.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LowAdminLayout(
      title: '用户管理',
      selectedIndex: 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '搜索用户',
                hintText: '输入用户ID、邮箱或用户名',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    '用户列表功能开发中',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showUserIdDialog(context),
                    icon: const Icon(Icons.person_search),
                    label: const Text('通过ID查看用户'),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      if (!mounted) return;
      router.go('/low_admin/user_v2/$result');
    }
  }
}
