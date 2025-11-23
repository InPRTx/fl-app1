import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/component/layout/user_layout_component.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserWrapperPage extends StatelessWidget {
  const UserWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserLayoutComponent(
      title: '用户中心',
      child: const AutoRouter(),
    );
  }
}
