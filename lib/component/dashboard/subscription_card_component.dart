import 'package:fl_app1/helper/clipboard_helper.dart';
import 'package:fl_app1/helper/subscription_helper.dart';
import 'package:fl_app1/store/model/subscription_model.dart';
import 'package:flutter/material.dart';

// 常量定义
const double _kTabContentMaxHeightFactor = 0.5;
const double _kTabContentMinHeight = 300.0;
const double _kContainerOpacity = 0.5;

/// 订阅卡片组件
class SubscriptionCardComponent extends StatefulWidget {
  const SubscriptionCardComponent({
    super.key,
    required this.subLinks,
    required this.shadowsocksPassword,
    required this.vmessPassword,
  });

  final List<String> subLinks;
  final String shadowsocksPassword;
  final String vmessPassword;

  @override
  State<SubscriptionCardComponent> createState() =>
      _SubscriptionCardComponentState();
}

class _SubscriptionCardComponentState extends State<SubscriptionCardComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedDomain;
  final Map<OperatingSystem, ClientType> _selectedClientTypes = {};
  final Map<OperatingSystem, bool> _linkVisibility = {};
  final Map<OperatingSystem, bool> _manualVisibility = {};
  final Map<OperatingSystem, bool> _hoverVisibility = {};

  @override
  void initState() {
    super.initState();
    // 初始化TabController (OS tabs + 配置tab)
    _tabController = TabController(
      length: OperatingSystem.values.length + 1,
      vsync: this,
    );

    // 初始化默认客户端类型选择
    for (final os in OperatingSystem.values) {
      final config = osConfigs[os];
      if (config != null && config.supportedClients.isNotEmpty) {
        _selectedClientTypes[os] = config.supportedClients.first;
      }
      _linkVisibility[os] = false;
      _manualVisibility[os] = false;
      _hoverVisibility[os] = false;
    }

    // 初始化域名选择
    if (widget.subLinks.isNotEmpty) {
      final domains = extractUniqueDomains(widget.subLinks);
      if (domains.isNotEmpty) {
        _selectedDomain = domains.first;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 获取当前选择的域名对应的订阅链接
  String _getCurrentBaseLink() {
    if (widget.subLinks.isEmpty) return '';
    if (_selectedDomain == null) return widget.subLinks.first;

    // 找到匹配选择域名的链接
    final matchedLink = widget.subLinks.firstWhere(
      (link) => extractDomainFromUrl(link) == _selectedDomain,
      orElse: () => widget.subLinks.first,
    );
    return matchedLink;
  }

  /// 获取特定操作系统的订阅链接
  String _getSubscriptionLink(OperatingSystem os) {
    final baseLink = _getCurrentBaseLink();
    if (baseLink.isEmpty) return '';

    // 自动识别不加后缀
    if (os == OperatingSystem.universal) {
      return baseLink;
    }

    // SSR特殊处理
    if (os == OperatingSystem.ssr) {
      return addSSRTypeToUrl(baseLink);
    }

    // 其他系统添加客户端类型
    final clientType = _selectedClientTypes[os];
    if (clientType != null) {
      return addClientTypeToUrl(baseLink, clientType.value);
    }

    return baseLink;
  }

  /// 获取最终链接可见性
  bool _getFinalLinkVisibility(OperatingSystem os) {
    return (_manualVisibility[os] ?? false) || (_hoverVisibility[os] ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final domains = extractUniqueDomains(widget.subLinks);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 卡片标题
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.download,
                  color: theme.colorScheme.onSecondary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  '订阅选择',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
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
                // 域名选择区域
                if (domains.length > 1) ...[
                  Row(
                    children: [
                      const Icon(Icons.web, size: 20),
                      const SizedBox(width: 8),
                      const Text('订阅域名选择'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedDomain,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.dns),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.help_outline, size: 20),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('域名选择说明'),
                              content: const Text(
                                '如果主域名无法访问，请尝试切换到其他备用域名。不同域名使用相同的订阅内容，只是服务器地址不同。',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('知道了'),
                                ),
                              ],
                            ),
                          );
                        },
                        tooltip: '域名选择帮助',
                      ),
                    ),
                    items: domains.map((domain) {
                      return DropdownMenuItem(
                        value: domain,
                        child: Text(domain),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedDomain = value);
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '当前使用域名：${_selectedDomain ?? '默认域名'}',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                ],

                // Tab切换
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    ...OperatingSystem.values.map((os) {
                      return Tab(
                        child: Row(
                          children: [
                            Icon(_getIconData(os.iconName), size: 20),
                            const SizedBox(width: 4),
                            Text(os.label),
                          ],
                        ),
                      );
                    }),
                    const Tab(
                      child: Row(
                        children: [
                          Icon(Icons.settings, size: 20),
                          SizedBox(width: 4),
                          Text('配置'),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Tab内容
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height *
                        _kTabContentMaxHeightFactor,
                    minHeight: _kTabContentMinHeight,
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ...OperatingSystem.values.map((os) {
                        return _buildOSTab(os);
                      }),
                      _buildConfigTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建操作系统选项卡
  Widget _buildOSTab(OperatingSystem os) {
    final theme = Theme.of(context);
    final config = osConfigs[os];
    if (config == null) return const SizedBox();

    final link = _getSubscriptionLink(os);
    final isVisible = _getFinalLinkVisibility(os);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 操作系统说明
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(
                alpha: _kContainerOpacity,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _getIconData(os.iconName),
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    config.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 客户端类型选择（universal和ssr除外）
          if (config.supportedClients.length > 1) ...[
            const Text(
              '选择客户端类型',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: config.supportedClients.map((clientType) {
                final isSelected = _selectedClientTypes[os] == clientType;
                return ChoiceChip(
                  label: Text(clientType.label),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedClientTypes[os] = clientType);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],

          // 订阅链接
          const Text('订阅链接', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          MouseRegion(
            onEnter: (_) {
              if (!(_manualVisibility[os] ?? false)) {
                setState(() => _hoverVisibility[os] = true);
              }
            },
            onExit: (_) {
              if (!(_manualVisibility[os] ?? false)) {
                setState(() => _hoverVisibility[os] = false);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      isVisible ? link : '••••••••',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _manualVisibility[os] =
                            !(_manualVisibility[os] ?? false);
                      });
                    },
                    tooltip: isVisible ? '隐藏链接' : '显示链接',
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () => copyToClipboard(context, link),
                    tooltip: '复制链接',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 推荐说明
          Text(
            config.recommendation,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 12),

          // 提示信息
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '提示：如果主要链接无法使用，请尝试切换域名',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建配置选项卡
  Widget _buildConfigTab() {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 配置说明
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(
                alpha: _kContainerOpacity,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.settings, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                const Expanded(child: Text('连接配置密码')),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Shadowsocks密码
          _buildPasswordField(
            'Shadowsocks密码',
            widget.shadowsocksPassword,
            Icons.security,
          ),

          const SizedBox(height: 16),

          // VMess密码
          _buildPasswordField(
            'VMess密码',
            widget.vmessPassword,
            Icons.fingerprint,
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // 密码使用说明
          const Text('密码使用说明：', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _buildInfoItem('• Shadowsocks密码用于SS协议连接'),
          _buildInfoItem('• VMess密码用于V2Ray协议连接'),
          _buildInfoItem('• 密码仅用于手动配置客户端'),
        ],
      ),
    );
  }

  /// 构建密码字段
  Widget _buildPasswordField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: SelectableText(
                  value,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () => copyToClipboard(context, value),
                tooltip: '复制',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建信息项
  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }

  /// 根据图标名称获取IconData
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'earth':
        return Icons.public;
      case 'desktop_windows':
        return Icons.desktop_windows;
      case 'android':
        return Icons.android;
      case 'apple':
        return Icons.apple;
      case 'phone_iphone':
        return Icons.phone_iphone;
      case 'shield':
        return Icons.shield;
      case 'computer':
        return Icons.computer;
      default:
        return Icons.devices;
    }
  }
}
