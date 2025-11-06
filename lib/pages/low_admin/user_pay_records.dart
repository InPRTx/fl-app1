import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/utils/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserPayRecordsPage extends StatefulWidget {
  final int userId;

  const UserPayRecordsPage({super.key, required this.userId});

  @override
  State<UserPayRecordsPage> createState() => _UserPayRecordsPageState();
}

class _UserPayRecordsPageState extends State<UserPayRecordsPage> {
  late final RestClient _restClient = createAuthenticatedClient();

  bool _isLoading = false;
  List<UserPayList> _payRecords = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserPayRecords();
  }

  Future<void> _loadUserPayRecords() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _restClient.fallback
        .getUserPayListApiV2LowAdminApiUserPayListGet(
          limit: 3000,
          userId: widget.userId,
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
        _payRecords = [];
      }
    });
  }

  Future<void> _deletePayRecord(String? payId) async {
    if (payId == null || payId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('无效的充值记录ID')));
      }
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这条充值记录吗？此操作不可恢复。'),
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

    final result = await _restClient.fallback
        .deleteUserPayListApiV2LowAdminApiUserPayListUserPayListIdDelete(
          userPayListId: payId,
        );

    if (mounted) {
      if (result.isSuccess == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('删除成功')));
        await _loadUserPayRecords();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('删除失败: ${result.message}')));
      }
    }
  }

  Future<void> _editPayRecord(UserPayList record) async {
    if (record.id == null || record.id!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('无效的充值记录ID')));
      }
      return;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EditPayRecordDialog(record: record),
    );

    if (result == null) return;

    final body = WebSubFastapiRoutersApiVLowAdminApiUserPayListPutParamsModel(
      moneyAmount: result['moneyAmount'],
      isFinish: result['isFinish'] as bool,
      tradeNo: result['tradeNo'] as String,
      payMethodId: result['payMethodId'] as int,
      invoiceId: result['invoiceId'] as String?,
      remark: result['remark'] as String?,
    );

    final response = await _restClient.fallback
        .putUserPayListApiV2LowAdminApiUserPayListUserPayListIdPut(
          userPayListId: record.id!,
          body: body,
        );

    if (mounted) {
      if (response.isSuccess == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('更新成功')));
        await _loadUserPayRecords();
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
        title: Text('充值记录 - 用户ID: ${widget.userId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadUserPayRecords,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null && _payRecords.isEmpty
          ? Center(
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
                    _errorMessage!,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadUserPayRecords,
                    icon: const Icon(Icons.refresh),
                    label: const Text('重试'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadUserPayRecords,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _payRecords.length,
                itemBuilder: (context, index) {
                  final record = _payRecords[index];
                  return _buildPayCard(record);
                },
              ),
            ),
    );
  }

  Widget _buildPayCard(UserPayList record) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

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
                  child: _buildInfoItem(
                    Icons.person,
                    '用户ID',
                    record.userId.toString(),
                  ),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _editPayRecord(record),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('编辑'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _deletePayRecord(record.id ?? ''),
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

class _EditPayRecordDialog extends StatefulWidget {
  final UserPayList record;

  const _EditPayRecordDialog({required this.record});

  @override
  State<_EditPayRecordDialog> createState() => _EditPayRecordDialogState();
}

class _EditPayRecordDialogState extends State<_EditPayRecordDialog> {
  late final TextEditingController _moneyAmountController;
  late final TextEditingController _tradeNoController;
  late final TextEditingController _payMethodIdController;
  late final TextEditingController _invoiceIdController;
  late final TextEditingController _remarkController;
  late bool _isFinish;

  @override
  void initState() {
    super.initState();
    _moneyAmountController = TextEditingController(
      text: widget.record.moneyAmount,
    );
    _tradeNoController = TextEditingController(text: widget.record.tradeNo);
    _payMethodIdController = TextEditingController(
      text: widget.record.payMethodId.toString(),
    );
    _invoiceIdController = TextEditingController(
      text: widget.record.invoiceId ?? '',
    );
    _remarkController = TextEditingController(text: widget.record.remark ?? '');
    _isFinish = widget.record.isFinish;
  }

  @override
  void dispose() {
    _moneyAmountController.dispose();
    _tradeNoController.dispose();
    _payMethodIdController.dispose();
    _invoiceIdController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void _save() {
    final moneyAmount = _moneyAmountController.text.trim();
    if (moneyAmount.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入金额')));
      return;
    }

    final tradeNo = _tradeNoController.text.trim();
    if (tradeNo.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入交易单号')));
      return;
    }

    final payMethodId = int.tryParse(_payMethodIdController.text);
    if (payMethodId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入有效的支付方式ID')));
      return;
    }

    Navigator.of(context).pop({
      'moneyAmount': moneyAmount,
      'isFinish': _isFinish,
      'tradeNo': tradeNo,
      'payMethodId': payMethodId,
      'invoiceId': _invoiceIdController.text.trim().isEmpty
          ? null
          : _invoiceIdController.text.trim(),
      'remark': _remarkController.text.trim().isEmpty
          ? null
          : _remarkController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('编辑充值记录'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _moneyAmountController,
              decoration: const InputDecoration(
                labelText: '金额',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tradeNoController,
              decoration: const InputDecoration(
                labelText: '交易单号',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.receipt_long),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _payMethodIdController,
              decoration: const InputDecoration(
                labelText: '支付方式ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payment),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _invoiceIdController,
              decoration: const InputDecoration(
                labelText: '发票ID（可选）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.receipt),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _remarkController,
              decoration: const InputDecoration(
                labelText: '备注（可选）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('是否完成'),
              subtitle: Text(_isFinish ? '已完成' : '未完成'),
              value: _isFinish,
              onChanged: (value) {
                setState(() {
                  _isFinish = value;
                });
              },
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
                      '注意：修改充值记录可能影响用户的账户余额',
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
