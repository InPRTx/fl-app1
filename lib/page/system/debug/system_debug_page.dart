import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SystemDebugPage extends StatelessWidget {
  const SystemDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '调试工具',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.public),
                title: const Text('时区查看器'),
                subtitle: const Text('查看不同时区的时间'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  context.go('/system/debug/view_timezone');
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('系统信息'),
                subtitle: const Text('查看系统运行信息'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('功能开发中')));
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text('调试日志'),
                subtitle: const Text('查看应用运行日志'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('功能开发中')));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '性能监控',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.speed),
                title: const Text('性能分析'),
                subtitle: const Text('查看应用性能指标'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('功能开发中')));
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.memory),
                title: const Text('内存使用'),
                subtitle: const Text('查看内存占用情况'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('功能开发中')));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
