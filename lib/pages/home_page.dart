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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const AuthStatusWidget(),
            const SizedBox(height: 16),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('打开登录页面'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/version'),
              child: const Text('查看 /v1/version'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/low_admin'),
              child: const Text('低权限管理后台'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/low_admin/user_v2/3'),
              child: const Text('查看用户详情（示例ID=3）'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
