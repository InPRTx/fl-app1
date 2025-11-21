import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/component/low_admin/editable_user_old_service_card_component.dart';
import 'package:fl_app1/component/low_admin/editable_user_v2_info_card_component.dart';
import 'package:fl_app1/component/low_admin/user_money_card_component.dart';
import 'package:fl_app1/page/low_admin/user_money_recharge/low_admin_user_money_recharge_page.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LowAdminUserDetailPage extends StatefulWidget {
  final int userId;

  const LowAdminUserDetailPage({super.key, required this.userId});

  @override
  State<LowAdminUserDetailPage> createState() => _LowAdminUserDetailPageState();
}

class _LowAdminUserDetailPageState extends State<LowAdminUserDetailPage> {
  late final RestClient _restClient = createAuthenticatedClient();

  bool _isLoading = false;
  AdminUserV? _userV2Data;
  AdminOldServiceOutput? _userOldServiceData;
  AdminUserMoneyModel? _userMoneyData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final client = _restClient.fallback;

    final results = await Future.wait<dynamic>([
      client.getUserV2ByUserIdApiV2LowAdminApiUserV2UserIdGet(
        userId: widget.userId,
      ),
      client.getUserOldServiceApiV2LowAdminApiUserOldServiceUserIdGet(
        userId: widget.userId,
      ),
      client.getUserV2ByUserIdApiV2LowAdminApiUserMoneyUserIdGet(
        userId: widget.userId,
      ),
    ]);

    setState(() {
      _isLoading = false;
      _userV2Data =
          (results[0]
                  as WebSubFastapiRoutersApiVLowAdminApiUserVGetUserOldServiceResponse)
              .result;
      _userOldServiceData =
          (results[1]
                  as WebSubFastapiRoutersApiVLowAdminApiUserOldServiceGetUserOldServiceResponse)
              .result;
      _userMoneyData = (results[2] as GetUserMoneyResponse).result;
    });
  }

  Future<bool> _updateUserV2(Map<String, dynamic> data) async {
    if (_userV2Data == null) return false;

    final body = AdminUserV(
      id: _userV2Data!.id,
      createdAt: _userV2Data!.createdAt,
      email: data['email'] as String,
      userName: data['userName'] as String,
      isEnabled: data['isEnabled'] as bool,
      isEmailVerify: data['isEmailVerify'] as bool,
      userAccountExpireIn: (data['userAccountExpireIn'] as DateTime).toUtc(),
      tgId: data['tgId'] as int?,
      regIp: _userV2Data!.regIp,
    );

    final response = await _restClient.fallback
        .putUserV2ApiV2LowAdminApiUserV2UserIdPut(
          userId: widget.userId,
          body: body,
        );

    if (response.isSuccess == true) {
      await _loadUserData();
      return true;
    }
    return false;
  }

  Future<bool> _updateUserOldService(Map<String, dynamic> data) async {
    final body = AdminOldServiceInput(
      ssUploadSize: data['ssUploadSize'] as int,
      ssDownloadSize: data['ssDownloadSize'] as int,
      ssBandwidthTotalSize: data['ssBandwidthTotalSize'] as int,
      userLevelExpireIn: (data['userLevelExpireIn'] as DateTime).toUtc(),
      // 有默认值的字段，需要提供非 null 值
      ssBandwidthYesterdayUsedSize:
          data['ssBandwidthYesterdayUsedSize'] as int? ?? 0,
      userLevel: data['userLevel'] as int? ?? 0,
      // 可选字段，允许 null
      nodeConnector: data['nodeConnector'] as int?,
      autoResetDay: data['autoResetDay'] as int?,
      autoResetBandwidth: data['autoResetBandwidth'],
      nodeSpeedLimit: data['nodeSpeedLimit'],
      ssLastUsedTime: _userOldServiceData?.ssLastUsedTime,
      lastCheckInTime: _userOldServiceData?.lastCheckInTime,
    );

    final response = await _restClient.fallback
        .putUserOldServiceApiV2LowAdminApiUserOldServiceUserIdPut(
          userId: widget.userId,
          body: body,
        );

    if (response.isSuccess == true) {
      await _loadUserData();
      return true;
    }
    return false;
  }

  Future<void> _navigateToRecharge() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) =>
            LowAdminUserMoneyRechargePage(userId: widget.userId),
      ),
    );

    if (result == true) {
      await _loadUserData();
    }
  }

  Future<void> _navigateToBoughtRecords() async {
    // 导航到购买记录列表页面，并带上user_id查询参数
    context.go('/low_admin/user_bought?q=user_id:${widget.userId}');
  }

  Future<void> _navigateToPayRecords() async {
    // 导航到充值记录列表页面，并带上user_id查询参数
    context.go('/low_admin/user_pay_list?q=user_id:${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户信息 - ID: ${widget.userId}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/low_admin/user_bought');
            }
          },
          tooltip: '返回',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadUserData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red[700]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadUserData,
                    child: const Text('重试'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  EditableUserV2InfoCardComponent(
                    userData: _userV2Data,
                    onUpdate: _updateUserV2,
                  ),
                  const SizedBox(height: 16),
                  EditableUserOldServiceCardComponent(
                    serviceData: _userOldServiceData,
                    onUpdate: _updateUserOldService,
                  ),
                  const SizedBox(height: 16),
                  UserMoneyCardComponent(
                    moneyData: _userMoneyData,
                    onRecharge: _navigateToRecharge,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_bag,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('购买记录'),
                      subtitle: const Text('查看和管理用户的购买记录'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _navigateToBoughtRecords,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_balance_wallet,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text('充值记录'),
                      subtitle: const Text('查看和管理用户的充值记录'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _navigateToPayRecords,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
