import 'package:fl_app1/widgets/auth_status_widget.dart';
import 'package:fl_app1/widgets/simple_layout_with_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SimpleLayoutWithMenu(
      title: widget.title,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const AuthStatusWidget(),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('打开登录页面'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/user/dashboard'),
              child: const Text('前往用户首页'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/low_admin'),
              child: const Text('前往管理主页'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
