import 'package:fl_app1/component/bought_records/bought_records_list_component.dart';
import 'package:flutter/material.dart';

class LowAdminUserBoughtRecordsPage extends StatelessWidget {
  final int userId;

  const LowAdminUserBoughtRecordsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购买记录 - 用户ID: $userId'),
      ),
      body: BoughtRecordsListComponent(
        userId: userId,
        isShowActions: true,
        isEnableUserIdNavigation: false,
      ),
    );
  }
}
