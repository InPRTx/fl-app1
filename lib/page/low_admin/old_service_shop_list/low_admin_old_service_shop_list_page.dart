import 'package:fl_app1/api/models/get_old_service_shop_list_response.dart';
import 'package:fl_app1/api/models/old_service_shop_input.dart';
import 'package:fl_app1/api/models/old_service_shop_output.dart';
import 'package:fl_app1/api/models/shop_type_enum.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class LowAdminOldServiceShopListPage extends StatefulWidget {
  const LowAdminOldServiceShopListPage({super.key});

  @override
  State<LowAdminOldServiceShopListPage> createState() =>
      _LowAdminOldServiceShopListPageState();
}

class _LowAdminOldServiceShopListPageState
    extends State<LowAdminOldServiceShopListPage> {
  final TextEditingController _searchController = TextEditingController();
  late final RestClient _restClient = createAuthenticatedClient();

  List<OldServiceShopOutput> _shops = [];
  bool _isLoading = false;
  String? _errorMessage;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadShops() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String query = _searchController.text.trim();

    final GetOldServiceShopListResponse result = await _restClient.fallback
        .getOldServiceShopApiV2LowAdminApiOldServiceShopGet(
          q: query.isEmpty ? null : query,
          limit: 3000,
          offset: 0,
        );

    if (!mounted) return;

    setState(() {
      _isLoading = false;

      if (result.isSuccess) {
        _shops = result.resultList;
        if (_shops.isEmpty) {
          _errorMessage = '未找到匹配的商品';
        }
      } else {
        _errorMessage = result.message;
        _shops = [];
      }
    });
  }

  String _getShopTypeName(ShopTypeEnum type) {
    switch (type) {
      case ShopTypeEnum.mainPackage:
        return '主套餐';
      case ShopTypeEnum.additionalPackage:
        return '附加套餐';
      case ShopTypeEnum.checkinPackage:
        return '签到套餐';
      case ShopTypeEnum.debuffPackage:
        return '负面套餐';
    }
  }

  String _formatBytes(int? bytes) {
    if (bytes == null) return 'N/A';
    if (bytes == 0) return '0 B';

    const List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int unitIndex = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(2)} ${units[unitIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: '查询参数 (q)',
                    hintText: '例如: 商品名称 或留空查询所有',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _loadShops();
                      },
                    )
                        : null,
                    border: const OutlineInputBorder(),
                    helperText: '支持搜索商品名称或ID',
                  ),
                  onSubmitted: (_) => _loadShops(),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _loadShops,
                icon: Icon(_searchController.text
                    .trim()
                    .isEmpty
                    ? Icons.refresh
                    : Icons.search),
                label: Text(_searchController.text
                    .trim()
                    .isEmpty
                    ? '全部'
                    : '搜索'),
              ),
            ],
          ),
        ),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('加载中...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadShops,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_shops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '暂无商品数据',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '输入查询参数搜索，支持搜索商品名称或ID',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadShops,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: _shops.length,
        itemBuilder: (context, index) {
          final shop = _shops[index];
          return _buildShopCard(shop);
        },
      ),
    );
  }

  Widget _buildShopCard(OldServiceShopOutput shop) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: InkWell(
        onTap: () => _showShopDetailDialog(shop),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                shop.shopName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: shop.isEnable
                                    ? Colors.green.withValues(alpha: 0.2)
                                    : Colors.red.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                shop.isEnable ? '启用' : '禁用',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: shop.isEnable
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getShopTypeName(shop.shopType),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(Icons.tag, 'ID', shop.id.toString()),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.attach_money,
                      '价格',
                      '¥${shop.moneyAmount}',
                    ),
                  ),
                  if (shop.userLevel != null)
                    Expanded(
                      child: _buildInfoItem(
                        Icons.grade,
                        '等级',
                        shop.userLevel.toString(),
                      ),
                    ),
                ],
              ),
              if (shop.ssBandwidthTotalSize != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        Icons.data_usage,
                        '流量',
                        _formatBytes(shop.ssBandwidthTotalSize),
                      ),
                    ),
                    if (shop.userLevelDuration != null)
                      Expanded(
                        child: _buildInfoItem(
                          Icons.access_time,
                          '等级有效期',
                          '${shop.userLevelDuration}',
                        ),
                      ),
                    if (shop.accountValidityDuration != null)
                      Expanded(
                        child: _buildInfoItem(
                          Icons.calendar_today,
                          '账户有效期',
                          '${shop.accountValidityDuration}',
                        ),
                      ),
                  ],
                ),
              ],
              if (shop.createdAt != null) ...[
                const SizedBox(height: 8),
                Text(
                  '创建时间: ${dateFormat.format(tz.TZDateTime.from(shop.createdAt!, tz.local))}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showShopDetailDialog(OldServiceShopOutput shop) {
    showDialog<void>(
      context: context,
      builder: (context) =>
          _ShopDetailDialog(shop: shop, onRefresh: _loadShops),
    );
  }
}

class _ShopDetailDialog extends StatefulWidget {
  final OldServiceShopOutput shop;
  final VoidCallback onRefresh;

  const _ShopDetailDialog({required this.shop, required this.onRefresh});

  @override
  State<_ShopDetailDialog> createState() => _ShopDetailDialogState();
}

class _ShopDetailDialogState extends State<_ShopDetailDialog> {
  late final RestClient _restClient = createAuthenticatedClient();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  bool _isEditing = false;
  bool _isSaving = false;

  late final TextEditingController _shopNameController;
  late final TextEditingController _moneyAmountController;
  late final TextEditingController _contentExtraController;
  late final TextEditingController _shopGroupIdController;
  late final TextEditingController _ssBandwidthTotalSizeController;
  late final TextEditingController _userLevelController;
  late final TextEditingController _userLevelDurationController;
  late final TextEditingController _accountValidityDurationController;
  late final TextEditingController _ssBandwidthResetIntervalController;
  late final TextEditingController _nodeSpeedLimitController;
  late final TextEditingController _nodeConnectorController;

  late ShopTypeEnum _shopType;
  late bool _isAutoResetBandwidth;
  late bool _isEnable;
  late bool _isCannotNewPurchase;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _shopNameController = TextEditingController(text: widget.shop.shopName);
    _moneyAmountController = TextEditingController(
      text: widget.shop.moneyAmount,
    );
    _contentExtraController = TextEditingController(
      text: widget.shop.contentExtra,
    );
    _shopGroupIdController = TextEditingController(
      text: widget.shop.shopGroupId.toString(),
    );
    _ssBandwidthTotalSizeController = TextEditingController(
      text: widget.shop.ssBandwidthTotalSize?.toString() ?? '',
    );
    _userLevelController = TextEditingController(
      text: widget.shop.userLevel?.toString() ?? '',
    );
    _userLevelDurationController = TextEditingController(
      text: widget.shop.userLevelDuration ?? '',
    );
    _accountValidityDurationController = TextEditingController(
      text: widget.shop.accountValidityDuration ?? '',
    );
    _ssBandwidthResetIntervalController = TextEditingController(
      text: widget.shop.ssBandwidthResetInterval ?? '',
    );
    _nodeSpeedLimitController = TextEditingController(
      text: widget.shop.nodeSpeedLimit?.toString() ?? '',
    );
    _nodeConnectorController = TextEditingController(
      text: widget.shop.nodeConnector?.toString() ?? '',
    );

    _shopType = widget.shop.shopType;
    _isAutoResetBandwidth = widget.shop.isAutoResetBandwidth;
    _isEnable = widget.shop.isEnable;
    _isCannotNewPurchase = widget.shop.isCannotNewPurchase;
  }

  void _resetControllers() {
    // 重置控制器的值为原始数据，而不是重新初始化
    _shopNameController.text = widget.shop.shopName;
    _moneyAmountController.text = widget.shop.moneyAmount;
    _contentExtraController.text = widget.shop.contentExtra;
    _shopGroupIdController.text = widget.shop.shopGroupId.toString();
    _ssBandwidthTotalSizeController.text =
        widget.shop.ssBandwidthTotalSize?.toString() ?? '';
    _userLevelController.text = widget.shop.userLevel?.toString() ?? '';
    _userLevelDurationController.text =
        widget.shop.userLevelDuration ?? '';
    _accountValidityDurationController.text =
        widget.shop.accountValidityDuration ?? '';
    _ssBandwidthResetIntervalController.text =
        widget.shop.ssBandwidthResetInterval ?? '';
    _nodeSpeedLimitController.text =
        widget.shop.nodeSpeedLimit?.toString() ?? '';
    _nodeConnectorController.text =
        widget.shop.nodeConnector?.toString() ?? '';

    setState(() {
      _shopType = widget.shop.shopType;
      _isAutoResetBandwidth = widget.shop.isAutoResetBandwidth;
      _isEnable = widget.shop.isEnable;
      _isCannotNewPurchase = widget.shop.isCannotNewPurchase;
    });
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _moneyAmountController.dispose();
    _contentExtraController.dispose();
    _shopGroupIdController.dispose();
    _ssBandwidthTotalSizeController.dispose();
    _userLevelController.dispose();
    _userLevelDurationController.dispose();
    _accountValidityDurationController.dispose();
    _ssBandwidthResetIntervalController.dispose();
    _nodeSpeedLimitController.dispose();
    _nodeConnectorController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    final body = OldServiceShopInput(
      id: widget.shop.id,
      shopName: _shopNameController.text,
      moneyAmount: _moneyAmountController.text,
      contentExtra: _contentExtraController.text,
      shopGroupId: int.tryParse(_shopGroupIdController.text) ?? 0,
      shopType: _shopType,
      isAutoResetBandwidth: _isAutoResetBandwidth,
      isEnable: _isEnable,
      isCannotNewPurchase: _isCannotNewPurchase,
      ssBandwidthTotalSize: _ssBandwidthTotalSizeController.text.isEmpty
          ? null
          : int.tryParse(_ssBandwidthTotalSizeController.text),
      userLevel: _userLevelController.text.isEmpty
          ? null
          : int.tryParse(_userLevelController.text),
      userLevelDuration: _userLevelDurationController.text.isEmpty
          ? null
          : _userLevelDurationController.text,
      accountValidityDuration: _accountValidityDurationController.text.isEmpty
          ? null
          : _accountValidityDurationController.text,
      ssBandwidthResetInterval: _ssBandwidthResetIntervalController.text.isEmpty
          ? null
          : _ssBandwidthResetIntervalController.text,
      nodeSpeedLimit: _nodeSpeedLimitController.text.isEmpty
          ? null
          : int.tryParse(_nodeSpeedLimitController.text),
      nodeConnector: _nodeConnectorController.text.isEmpty
          ? null
          : int.tryParse(_nodeConnectorController.text),
      createdAt: widget.shop.createdAt,
      updatedAt: widget.shop.updatedAt,
      dataJson: widget.shop.dataJson,
    );

    await _restClient.fallback
        .putOldServiceShopApiV2LowAdminApiOldServiceShopShopIdPut(
          shopId: widget.shop.id,
          body: body,
        );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
      _isEditing = false;
    });

    widget.onRefresh();

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('保存成功')));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Column(
          children: [
            AppBar(
              title: Text('商品详情 - ${widget.shop.shopName}'),
              actions: [
                if (!_isEditing)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                  )
                else ...[
                  TextButton(
                    onPressed: _isSaving
                        ? null
                        : () {
                      _resetControllers();
                            setState(() {
                              _isEditing = false;
                            });
                          },
                    child: const Text('取消'),
                  ),
                  TextButton(
                    onPressed: _isSaving ? null : _saveChanges,
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('保存'),
                  ),
                ],
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('商品名称', _shopNameController),
                    const SizedBox(height: 16),
                    _buildTextField('价格', _moneyAmountController),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '商品分组ID',
                      _shopGroupIdController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '流量（字节）',
                      _ssBandwidthTotalSizeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '等级',
                      _userLevelController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField('等级有效期', _userLevelDurationController),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '账户有效期',
                      _accountValidityDurationController,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '流量重置间隔',
                      _ssBandwidthResetIntervalController,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '端口限速',
                      _nodeSpeedLimitController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'IP限制',
                      _nodeConnectorController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      '服务支持',
                      _contentExtraController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    _buildSwitchTile('自动重置流量', _isAutoResetBandwidth, (value) {
                      setState(() {
                        _isAutoResetBandwidth = value;
                      });
                    }),
                    _buildSwitchTile('启用', _isEnable, (value) {
                      setState(() {
                        _isEnable = value;
                      });
                    }),
                    _buildSwitchTile('禁止新购买', _isCannotNewPurchase, (value) {
                      setState(() {
                        _isCannotNewPurchase = value;
                      });
                    }),
                    const SizedBox(height: 24),
                    if (widget.shop.createdAt != null) ...[
                      _buildReadOnlyField(
                        '创建时间',
                        _dateFormat.format(
                          tz.TZDateTime.from(widget.shop.createdAt!, tz.local),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (widget.shop.updatedAt != null) ...[
                      _buildReadOnlyField(
                        '更新时间',
                        _dateFormat.format(
                          tz.TZDateTime.from(widget.shop.updatedAt!, tz.local),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdown() {
    return InputDecorator(
      decoration: const InputDecoration(
        labelText: '商品类型',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ShopTypeEnum>(
          value: _shopType,
          isExpanded: true,
          onChanged: _isEditing
              ? (ShopTypeEnum? value) {
                  if (value != null) {
                    setState(() {
                      _shopType = value;
                    });
                  }
                }
              : null,
          items: ShopTypeEnum.values.map((ShopTypeEnum type) {
            return DropdownMenuItem<ShopTypeEnum>(
              value: type,
              child: Text(_getShopTypeName(type)),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getShopTypeName(ShopTypeEnum type) {
    switch (type) {
      case ShopTypeEnum.mainPackage:
        return '主套餐';
      case ShopTypeEnum.additionalPackage:
        return '附加套餐';
      case ShopTypeEnum.checkinPackage:
        return '签到套餐';
      case ShopTypeEnum.debuffPackage:
        return '负面套餐';
    }
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: _isEditing ? onChanged : null,
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value),
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
