import 'package:fl_app1/api/models/user_pay_list.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class LowAdminUserPayListPage extends StatefulWidget {
  const LowAdminUserPayListPage({super.key});

  @override
  State<LowAdminUserPayListPage> createState() =>
      _LowAdminUserPayListPageState();
}

class _LowAdminUserPayListPageState extends State<LowAdminUserPayListPage> {
  final TextEditingController _queryController = TextEditingController();
  late final RestClient _restClient = createAuthenticatedClient();

  List<UserPayList> _payRecords = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  String? _queryString;

  // Paging
  final ScrollController _scrollController = ScrollController();
  static const int _pageLimit = 50;
  int _offset = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // 延迟读取URL参数，确保GoRouter已经初始化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQueryFromUrl();
    });
  }

  void _loadQueryFromUrl() {
    final uri = GoRouterState
        .of(context)
        .uri;
    final qParam = uri.queryParameters['q'];
    if (qParam != null && qParam.isNotEmpty) {
      _queryController.text = qParam;
      setState(() {
        _queryString = qParam;
      });
      _fetchRecords();
    } else {
      _fetchRecords();
    }
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _applyQuery() {
    final text = _queryController.text.trim();
    setState(() {
      _queryString = text.isEmpty ? null : text;
    });
    _fetchRecords();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= (maxScroll - 200) &&
        !_isLoading &&
        !_isLoadingMore &&
        _hasMore) {
      _fetchRecords(isLoadMore: true);
    }
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
        .getUserPayListApiV2LowAdminApiUserPayListGet(
      limit: _pageLimit,
      offset: _offset,
      q: _queryString,
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
          _payRecords = List.from(_payRecords)
            ..addAll(fetched);
        } else {
          _payRecords = fetched;
        }

        if (fetched.length < _pageLimit) {
          _hasMore = false;
        } else {
          _hasMore = true;
          _offset += _pageLimit;
        }

        if (_payRecords.isEmpty) {
          _errorMessage =
          _queryString == null ? '暂无充值记录' : '该用户暂无充值记录';
        }
      } else {
        _errorMessage = result.message;
        if (!isLoadMore) {
          _payRecords = <UserPayList>[];
        }
      }
    });
  }

  Future<void> _confirmFinishPay(UserPayList record) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认完成充值'),
          content: Text(
            '是否确认为订单 ${record.tradeNo} 完成充值？\n\n'
                '用户ID: ${record.userId}\n'
                '金额: ¥${record.moneyAmount}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确认'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && record.id != null) {
      await _finishPay(record.id!);
    }
  }

  Future<void> _finishPay(String payListId) async {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      const SnackBar(
        content: Text('正在处理...'),
        duration: Duration(seconds: 1),
      ),
    );

    final result = await _restClient.fallback
        .adminNotifyApiV2LowAdminApiUserPayListUserPayListIdIsFinishNotifyPost(
      userPayListId: payListId,
    );

    if (!mounted) return;

    if (result.isSuccess) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('充值完成通知已发送'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // 刷新列表
      await _fetchRecords();
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text('操作失败: ${result.message}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
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
                  controller: _queryController,
                  decoration: InputDecoration(
                    labelText: '查询参数 (q)',
                    hintText: '例如: user_id:123 或留空查询所有',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _queryController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _queryController.clear();
                              _applyQuery();
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    helperText: '支持格式: user_id:123',
                  ),
                  onSubmitted: (_) => _applyQuery(),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _applyQuery,
                icon: Icon(_queryController.text
                    .trim()
                    .isEmpty
                    ? Icons.refresh
                    : Icons.search),
                label: Text(_queryController.text
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
              onPressed: _fetchRecords,
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_payRecords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '暂无充值记录',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '输入查询参数搜索，支持格式: user_id:123',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchRecords,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: _payRecords.length + 1,
        itemBuilder: (context, index) {
          if (index < _payRecords.length) {
            final record = _payRecords[index];
            return _buildPayCard(record);
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
              child: Center(
                  child: Text('到底了', style: TextStyle(color: Colors.grey))),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPayCard(UserPayList record) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
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
                            child: InkWell(
                              onTap: () async {
                                final tradeNo = record.tradeNo;
                                final messenger = ScaffoldMessenger.of(context);
                                await Clipboard.setData(
                                  ClipboardData(text: tradeNo),
                                );
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: Text('已复制交易单号: $tradeNo'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '交易单号: ${record.tradeNo}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.copy, size: 14),
                                ],
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
                              color: record.isFinish
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : Colors.orange.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              record.isFinish ? '已完成' : '未完成',
                              style: TextStyle(
                                fontSize: 12,
                                color: record.isFinish
                                    ? Colors.green[700]
                                    : Colors.orange[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () async {
                          final recordId = record.id ?? '';
                          final messenger = ScaffoldMessenger.of(context);
                          await Clipboard.setData(
                            ClipboardData(text: recordId),
                          );
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('已复制记录ID: $recordId'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '记录ID: ${record.id}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.copy, size: 12, color: Colors.grey[600]),
                          ],
                        ),
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
                  child: _buildClickableUserIdItem(context, record.userId),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.attach_money,
                    '金额',
                    '¥${record.moneyAmount}',
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.payment,
                    '支付方式',
                    '方式${record.payMethodId}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (record.createdAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      Icons.calendar_today,
                      '创建时间',
                      dateFormat.format(
                          tz.TZDateTime.from(record.createdAt!, tz.local)),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
                if (record.updatedAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      Icons.update,
                      '更新时间',
                      dateFormat.format(
                          tz.TZDateTime.from(record.updatedAt!, tz.local)),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
            if (record.invoiceId != null) ...[
              const SizedBox(height: 12),
              _buildInfoItem(Icons.receipt, '发票ID', record.invoiceId!),
            ],
            if (record.remark != null && record.remark!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildInfoItem(Icons.note, '备注', record.remark!),
            ],
            if (!record.isFinish) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _confirmFinishPay(record),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('完成充值'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
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

  Widget _buildClickableUserIdItem(BuildContext context, int userId) {
    return InkWell(
      onTap: () {
        context.go('/low_admin/user_v2/$userId');
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '用户ID',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  userId.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.open_in_new,
                  size: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
