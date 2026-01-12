import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/component/auth/auth_status_component.dart';
import 'package:fl_app1/page/system/system_view_default_const_page.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = 'Flutter Demo Home Page'});

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
          const AuthStatusComponent(),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.router.pushPath('/auth/login'),
            child: const Text('打开登录页面'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => context.router.pushPath('/user/dashboard'),
            child: const Text('前往用户首页'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const SystemViewDefaultConstPage();
                  },
                ),
              );
            },
            child: const Text('查看 Base URL'),
          ),
          const SizedBox(height: 8),
          if (_authStore.isAdmin) ...[
            ElevatedButton(
              onPressed: () => context.router.pushPath('/low_admin'),
              child: const Text('前往管理主页'),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
