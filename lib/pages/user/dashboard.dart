import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/utils/auth/authenticated_client.dart';
import 'package:fl_app1/widgets/dashboard/announcement_card.dart';
import 'package:fl_app1/widgets/dashboard/status_card.dart';
import 'package:fl_app1/widgets/dashboard/subscription_card.dart';
import 'package:fl_app1/widgets/dashboard/traffic_card.dart';
import 'package:fl_app1/widgets/user_layout.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _loading = true;
  String? _error;

  // 用户数据
  String _userLevel = '加载中...';
  String _userBalance = '加载中...';
  String _onlineIpLimit = '加载中...';
  String _connectionSpeed = '加载中...';

  // 流量数据
  int _totalBytes = 0;
  int _usedBytes = 0;
  int _todayUsedBytes = 0;
  DateTime? _expireDate;

  // 订阅数据
  List<String> _subLinks = [];
  String _shadowsocksPassword = '加载中...';
  String _vmessPassword = '加载中...';

  // 公告内容
  final String _announcementContent = '''
欢迎使用我们的服务！

请注意以下重要事项：
1. 请勿将账号分享给他人使用
2. 如遇到任何问题，请及时联系客服
3. 定期检查您的流量使用情况
4. 建议使用推荐的客户端以获得最佳体验

感谢您的支持！
''';

  late RestClient _restClient;

  @override
  void initState() {
    super.initState();
    _initApi();
    _fetchDashboardData();
  }

  void _initApi() {
    _restClient = createAuthenticatedClient();
  }

  Future<void> _fetchDashboardData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final response = await _restClient.fallback.getIndexApiV2UserDashboardGet();

    if (response.isSuccess) {
      final result = response.result;

      // 检查用户是否被封号
      if (result.isBan) {
        setState(() {
          _error = '您的账户已被封禁，如有疑问请联系客服';
          _loading = false;
        });
        return;
      }

      // 设置用户基本信息
      _userBalance = result.moneyAmount;

      final serviceInfo = result.oldServiceInfo;
      if (serviceInfo != null) {
        setState(() {
          // 设置用户数据
          _userLevel = serviceInfo.userLevelText;
          _onlineIpLimit = (serviceInfo.onlineIpLimit ?? 0).toString();
          _connectionSpeed = serviceInfo.speedLimit ?? '无限制';

          // 设置流量数据
          _totalBytes = serviceInfo.ssBandwidthTotalSize;
          _usedBytes = serviceInfo.ssUploadSize + serviceInfo.ssDownloadSize;
          _todayUsedBytes = serviceInfo.ssBandwidthTodayUsedSize;
          _expireDate = serviceInfo.userLevelExpireIn;

          // 设置订阅链接
          _subLinks = List<String>.from(serviceInfo.subLink);

          // 设置配置密码
          _shadowsocksPassword = serviceInfo.ssPasswd;
          _vmessPassword = serviceInfo.ssUuid;

          _loading = false;
        });
      } else {
        setState(() {
          _error = '无法获取服务信息';
          _loading = false;
        });
      }
    } else {
      setState(() {
        _error = response.message;
        _loading = false;
      });
    }
  }

  void _navigateToShop() {
    // TODO: 实现跳转到商店页面
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('商店页面正在开发中，敬请期待！')));
  }

  void _navigateToDataPackage() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('购买流量包功能正在开发中，敬请期待！')));
  }

  void _openExternalLink(String url) {
    // TODO: 实现外部链接打开功能
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('即将打开: $url')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return UserLayout(
      title: '用户主页',
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _loading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('加载中...', style: TextStyle(fontSize: 16)),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _fetchDashboardData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 错误提示
                      if (_error != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.colorScheme.error),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: theme.colorScheme.onErrorContainer,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: TextStyle(
                                    color: theme.colorScheme.onErrorContainer,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() => _error = null);
                                },
                              ),
                            ],
                          ),
                        ),

                      // 状态卡片
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.5,
                        children: [
                          StatusCard(
                            label: '用户等级',
                            value: _userLevel,
                            icon: Icons.star,
                            color: theme.colorScheme.primary,
                          ),
                          StatusCard(
                            label: '账户余额',
                            value: '¥$_userBalance',
                            icon: Icons.account_balance_wallet,
                            color: theme.colorScheme.secondary,
                          ),
                          StatusCard(
                            label: 'IP限制',
                            value: _onlineIpLimit,
                            icon: Icons.devices,
                            color: theme.colorScheme.tertiary,
                          ),
                          StatusCard(
                            label: '连接速度',
                            value: _connectionSpeed,
                            icon: Icons.speed,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 订阅和流量卡片
                      SubscriptionCard(
                        subLinks: _subLinks,
                        shadowsocksPassword: _shadowsocksPassword,
                        vmessPassword: _vmessPassword,
                      ),

                      const SizedBox(height: 16),

                      TrafficCard(
                        totalBytes: _totalBytes,
                        usedBytes: _usedBytes,
                        todayUsedBytes: _todayUsedBytes,
                        expireDate: _expireDate,
                        onNavigateToShop: _navigateToShop,
                        onNavigateToDataPackage: _navigateToDataPackage,
                      ),

                      const SizedBox(height: 16),

                      // 公告
                      AnnouncementCard(content: _announcementContent),

                      const SizedBox(height: 16),

                      // 赞助商广告
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.store,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '好货铺子',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '苹果账号/兑换码推荐商家',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/haohuopuzi.webp',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 150,
                                              color: theme
                                                  .colorScheme
                                                  .surfaceContainerHighest,
                                              child: Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                  color: theme
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () => _openExternalLink(
                                        'https://hhpz.store',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        foregroundColor:
                                            theme.colorScheme.onPrimary,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: const Text('了解更多'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
