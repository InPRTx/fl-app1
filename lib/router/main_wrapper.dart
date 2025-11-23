import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/component/layout/simple_layout_with_menu_component.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainWrapperPage extends StatelessWidget {
  const MainWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleLayoutWithMenuComponent(
      title: '首页菜单栏',
      child: const AutoRouter(),
    );
  }
}
