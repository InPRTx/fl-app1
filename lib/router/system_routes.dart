import 'package:fl_app1/component/layout/simple_layout_with_menu_component.dart';
import 'package:fl_app1/page/system/system_view_default_const_page.dart';
import 'package:go_router/go_router.dart';

final aa = (
  builder: (context, state, child) {
    return SimpleLayoutWithMenuComponent(title: '首页菜单栏', child: child);
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const SystemViewDefaultConstPage(),
    ),
  ],
);
