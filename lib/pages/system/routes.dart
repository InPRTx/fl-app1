import 'package:fl_app1/widgets/simple_layout_with_menu.dart';
import 'package:go_router/go_router.dart';

import 'system_view_default_const_page.dart';

final aa = (
  builder: (context, state, child) {
    return SimpleLayoutWithMenu(title: '首页菜单栏', child: child);
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const SystemViewDefaultConst(),
    ),
  ],
);
