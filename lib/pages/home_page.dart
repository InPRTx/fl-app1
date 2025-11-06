import 'package:fl_app1/pages/debug/base_url_page.dart';
import 'package:fl_app1/utils/auth/auth_store.dart';
import 'package:fl_app1/widgets/auth_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthStore _authStore = AuthStore();

  @override
  void initState() {
    super.initState();
    _authStore.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    _authStore.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const AuthStatusWidget(),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.go('/auth/login'),
            child: const Text('打开登录页面'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.go('/user/dashboard'),
            child: const Text('前往用户首页'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const BaseUrlPage()));
            },
            child: const Text('查看 Base URL'),
          ),
          const SizedBox(height: 8),
          if (_authStore.isAdmin) ...[
            ElevatedButton(
              onPressed: () => context.go('/low_admin'),
              child: const Text('前往管理主页'),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
