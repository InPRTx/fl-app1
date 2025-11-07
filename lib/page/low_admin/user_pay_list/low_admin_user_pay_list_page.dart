import 'package:fl_app1/api/models/user_pay_list.dart';
import 'package:fl_app1/api/models/web_sub_fastapi_routers_api_v_low_admin_api_user_pay_list_get_user_bought_response.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LowAdminUserPayListPage extends StatefulWidget {
  const LowAdminUserPayListPage({super.key});

  @override
  State<LowAdminUserPayListPage> createState() =>
      _LowAdminUserPayListPageState();
}

class _LowAdminUserPayListPageState extends State<LowAdminUserPayListPage> {
  final TextEditingController _userIdController = TextEditingController();
  late final RestClient _restClient = createAuthenticatedClient();

  List<UserPayList> _payRecords = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAllRecords();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  Future<void> _loadAllRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse
    result = await _restClient.fallback
        .getUserPayListApiV2LowAdminApiUserPayListGet(
          limit: 3000,
          userId: null,
        );

    setState(() {
      _isLoading = false;
      if (result.isSuccess) {
        _payRecords = result.resultList;
        if (_payRecords.isEmpty) {
          _errorMessage = '暂无充值记录';
        }
      } else {
        _errorMessage = result.message;
        _payRecords = <UserPayList>[];
      }
    });
  }

  Future<void> _searchByUserId() async {
    final String userIdText = _userIdController.text.trim();
    if (userIdText.isEmpty) {
      _loadAllRecords();
      return;
    }

    final int? userId = int.tryParse(userIdText);
    if (userId == null) {
      setState(() {
        _errorMessage = '请输入有效的用户ID';
        _payRecords = <UserPayList>[];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final WebSubFastapiRoutersApiVLowAdminApiUserPayListGetUserBoughtResponse
    result = await _restClient.fallback
        .getUserPayListApiV2LowAdminApiUserPayListGet(
          limit: 3000,
          userId: userId,
        );

    setState(() {
      _isLoading = false;
      if (result.isSuccess) {
        _payRecords = result.resultList;
        if (_payRecords.isEmpty) {
          _errorMessage = '该用户暂无充值记录';
        }
      } else {
        _errorMessage = result.message;
        _payRecords = <UserPayList>[];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ShellRoute provides LowAdminLayout (menu). Return only the page content.
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    labelText: '用户ID',
                    hintText: '输入用户ID搜索，留空查询所有记录',
                    prefixIcon: const Icon(Icons.person_search),
                    suffixIcon: _userIdController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _userIdController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _searchByUserId(),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _searchByUserId,
                icon: const Icon(Icons.search),
                label: const Text('搜索'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () {
                        _userIdController.clear();
                        _loadAllRecords();
                      },
                icon: const Icon(Icons.refresh),
                label: const Text('全部'),
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
              onPressed: _userIdController.text.isEmpty
                  ? _loadAllRecords
                  : _searchByUserId,
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
              '输入用户ID搜索指定用户的充值记录',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _payRecords.length,
      itemBuilder: (context, index) {
        final record = _payRecords[index];
        return _buildPayCard(record);
      },
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
                      dateFormat.format(record.createdAt!.toLocal()),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
                if (record.updatedAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      Icons.update,
                      '更新时间',
                      dateFormat.format(record.updatedAt!.toLocal()),
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
