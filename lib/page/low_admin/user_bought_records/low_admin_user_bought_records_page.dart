import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class LowAdminUserBoughtRecordsPage extends StatefulWidget {
  final int userId;

  const LowAdminUserBoughtRecordsPage({super.key, required this.userId});

  @override
  State<LowAdminUserBoughtRecordsPage> createState() =>
      _LowAdminUserBoughtRecordsPageState();
}

class _LowAdminUserBoughtRecordsPageState
    extends State<LowAdminUserBoughtRecordsPage> {
  late final RestClient _restClient = createAuthenticatedClient();

  bool _isLoading = false;
  bool _isLoadingMore = false;
  List<
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
  >
  _boughtRecords = [];
  String? _errorMessage;

  // Paging
  final ScrollController _scrollController = ScrollController();
  static const int _pageLimit = 50;
  int _offset = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchRecords();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= (maxScroll - 200) && !_isLoading && !_isLoadingMore &&
        _hasMore) {
      _fetchRecords(isLoadMore: true);
    }
  }

  Future<void> _loadUserBoughtRecords() async {
    // Keep backward-compatible call
    await _fetchRecords(isLoadMore: false);
  }

  Future<void> _fetchRecords({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (_isLoadingMore || !_hasMore) return;
      setState(() {
        _isLoadingMore = true;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _offset = 0;
        _hasMore = true;
      });
    }

    final result = await _restClient.fallback
        .getUserBoughtApiV2LowAdminApiUserBoughtGet(
      limit: _pageLimit,
      offset: _offset,
          userId: widget.userId,
        );

    if (!mounted) return;

    setState(() {
      if (isLoadMore) {
        _isLoadingMore = false;
      } else {
        _isLoading = false;
      }

      if (result.isSuccess) {
        final fetched = result.resultList;
        if (isLoadMore) {
          _boughtRecords = List.from(_boughtRecords)
            ..addAll(fetched);
        } else {
          _boughtRecords = fetched;
        }

        if (fetched.length < _pageLimit) {
          _hasMore = false;
        } else {
          _hasMore = true;
          _offset += _pageLimit;
        }

        if (_boughtRecords.isEmpty) {
          _errorMessage = '该用户暂无购买记录';
        }
      } else {
        _errorMessage = result.message;
        if (!isLoadMore) {
          _boughtRecords = [];
        }
      }
    });
  }

  Future<void> _deleteBoughtRecord(String boughtId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这条购买记录吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final boughtIdInt = int.tryParse(boughtId);
    if (boughtIdInt == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('无效的购买记录ID')));
      }
      return;
    }

    final result = await _restClient.fallback
        .deleteUserBoughtApiV2LowAdminApiUserBoughtBoughtIdDelete(
          boughtId: boughtIdInt,
        );

    if (mounted) {
      if (result.isSuccess == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('删除成功')));
        await _loadUserBoughtRecords();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('删除失败: ${result.message}')));
      }
    }
  }

  Future<void> _editBoughtRecord(
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
    record,
  ) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EditBoughtRecordDialog(record: record),
    );

    if (result == null) return;

    final boughtIdInt = int.tryParse(record.id);
    if (boughtIdInt == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('无效的购买记录ID')));
      }
      return;
    }

    // 提交前必须转换为 UTC 时间
    final body = WebSubFastapiRoutersApiVLowAdminApiUserBoughtPutParamsModel(
      shopId: result['shopId'] as int,
      createdAt: (result['createdAt'] as DateTime).toUtc(),
      moneyAmount: result['moneyAmount'],
    );

    final response = await _restClient.fallback
        .putUserBoughtApiV2LowAdminApiUserBoughtBoughtIdPut(
          boughtId: boughtIdInt,
          body: body,
        );

    if (mounted) {
      if (response.isSuccess == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('更新成功')));
        await _loadUserBoughtRecords();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('更新失败: ${response.message}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购买记录 - 用户ID: ${widget.userId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadUserBoughtRecords,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null && _boughtRecords.isEmpty
          ? Center(
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
                    _errorMessage!,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadUserBoughtRecords,
                    icon: const Icon(Icons.refresh),
                    label: const Text('重试'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserBoughtRecords,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _boughtRecords.length + 1,
                itemBuilder: (context, index) {
                  if (index < _boughtRecords.length) {
                    final record = _boughtRecords[index];
                    return _buildBoughtCard(record);
                  }
                  if (_isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (!_hasMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(child: Text(
                          '到底了', style: TextStyle(color: Colors.grey))),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
    );
  }

  Widget _buildBoughtCard(
    WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
    record,
  ) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    // 将 UTC 时间转换为本地时间进行比较和显示
    final localExpireAt = record.expireAt != null
        ? tz.TZDateTime.from(record.expireAt!, tz.local)
        : null;
    final isExpired =
        localExpireAt != null &&
            localExpireAt.isBefore(tz.TZDateTime.now(tz.local));

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
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
                              record.shopName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (record.expireAt != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isExpired
                                    ? Colors.red.withValues(alpha: 0.2)
                                    : Colors.green.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isExpired ? '已过期' : '有效',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isExpired
                                      ? Colors.red[700]
                                      : Colors.green[700],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '订单ID: ${record.id}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.person,
                    '用户ID',
                    record.userId.toString(),
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.shopping_bag,
                    '商品ID',
                    record.shopId.toString(),
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.attach_money,
                    '金额',
                    '¥${record.moneyAmount}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    Icons.calendar_today,
                    '购买时间',
                    dateFormat.format(
                        tz.TZDateTime.from(record.createdAt, tz.local)),
                  ),
                ),
                if (localExpireAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      Icons.event,
                      '过期时间',
                      dateFormat.format(localExpireAt),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _editBoughtRecord(record),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('编辑'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _deleteBoughtRecord(record.id),
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('删除'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _EditBoughtRecordDialog extends StatefulWidget {
  final WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData
  record;

  const _EditBoughtRecordDialog({required this.record});

  @override
  State<_EditBoughtRecordDialog> createState() =>
      _EditBoughtRecordDialogState();
}

class _EditBoughtRecordDialogState extends State<_EditBoughtRecordDialog> {
  late final TextEditingController _shopIdController;
  late final TextEditingController _moneyAmountController;
  late DateTime _createdAt;

  @override
  void initState() {
    super.initState();
    _shopIdController = TextEditingController(
      text: widget.record.shopId.toString(),
    );
    _moneyAmountController = TextEditingController(
      text: widget.record.moneyAmount,
    );
    // API 返回的是 UTC 时间，转换为本地时间供编辑使用
    _createdAt = tz.TZDateTime.from(widget.record.createdAt, tz.local);
  }

  @override
  void dispose() {
    _shopIdController.dispose();
    _moneyAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_createdAt),
    );

    if (time == null) return;

    setState(() {
      _createdAt = tz.TZDateTime(
        tz.local,
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _save() {
    final shopId = int.tryParse(_shopIdController.text);
    if (shopId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入有效的商品ID')));
      return;
    }

    final moneyAmount = _moneyAmountController.text.trim();
    if (moneyAmount.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入金额')));
      return;
    }

    Navigator.of(context).pop({
      'shopId': shopId,
      'createdAt': _createdAt,
      'moneyAmount': moneyAmount,
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return AlertDialog(
      title: const Text('编辑购买记录'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _shopIdController,
              decoration: const InputDecoration(
                labelText: '商品ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _moneyAmountController,
              decoration: const InputDecoration(
                labelText: '金额',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _selectDateTime,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: '购买时间',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  dateFormat.format(_createdAt),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '注意：修改购买记录可能影响用户的服务状态',
                      style: TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(onPressed: _save, child: const Text('保存')),
      ],
    );
  }
}
