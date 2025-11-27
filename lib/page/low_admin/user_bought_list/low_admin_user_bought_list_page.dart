import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/component/bought_records/bought_records_list_component.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

@RoutePage()
class LowAdminUserBoughtListPage extends StatefulWidget {
  const LowAdminUserBoughtListPage({
    super.key,
    @QueryParam('q') this.queryParam,
  });

  final String? queryParam;

  @override
  State<LowAdminUserBoughtListPage> createState() =>
      _LowAdminUserBoughtListPageState();
}

class _LowAdminUserBoughtListPageState
    extends State<LowAdminUserBoughtListPage> {
  final TextEditingController _queryController = TextEditingController();
  String? _queryString;

  @override
  void initState() {
    super.initState();
    // 从路由参数初始化查询字符串
    if (widget.queryParam != null && widget.queryParam!.isNotEmpty) {
      _queryController.text = widget.queryParam!;
      _queryString = widget.queryParam;
    }
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _applyQuery() {
    final text = _queryController.text.trim();
    setState(() {
      _queryString = text.isEmpty ? null : text;
    });
  }

  Future<void> _showAddRecordDialog() async {
    // 从查询字符串中提取 user_id
    int? presetUserId;
    if (_queryString != null && _queryString!.contains('user_id:')) {
      final match = RegExp(r'user_id:(\d+)').firstMatch(_queryString!);
      if (match != null) {
        presetUserId = int.tryParse(match.group(1)!);
      }
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _AddBoughtRecordDialog(presetUserId: presetUserId),
    );

    if (result == true && mounted) {
      // 刷新列表
      setState(() {
        _queryString = _queryString; // 触发列表刷新
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 搜索栏（可滚动）
          SliverToBoxAdapter(
            child: Padding(
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
                        helperText: '支持格式: user_id:123 id: shop_id:',
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
                    icon: Icon(
                      _queryController.text.trim().isEmpty
                          ? Icons.refresh
                          : Icons.search,
                    ),
                    label: Text(
                      _queryController.text.trim().isEmpty ? '全部' : '搜索',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 购买记录列表组件
          SliverFillRemaining(
            child: BoughtRecordsListComponent(
              key: ValueKey(_queryString),
              q: _queryString,
              isShowActions: true,
              isEnableUserIdNavigation: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddRecordDialog,
        icon: const Icon(Icons.add),
        label: const Text('添加记录'),
      ),
    );
  }
}

/// 添加购买记录对话框
class _AddBoughtRecordDialog extends StatefulWidget {
  final int? presetUserId;

  const _AddBoughtRecordDialog({this.presetUserId});

  @override
  State<_AddBoughtRecordDialog> createState() => _AddBoughtRecordDialogState();
}

class _AddBoughtRecordDialogState extends State<_AddBoughtRecordDialog> {
  late final RestClient _restClient = createAuthenticatedClient();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _userIdController;
  late final TextEditingController _shopIdController;
  late final TextEditingController _moneyAmountController;
  late DateTime _createdAt;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _userIdController = TextEditingController(
      text: widget.presetUserId?.toString() ?? '',
    );
    _shopIdController = TextEditingController();
    _moneyAmountController = TextEditingController();
    _createdAt = DateTime.now();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _shopIdController.dispose();
    _moneyAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _createdAt,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_createdAt),
    );

    if (time == null || !mounted) return;

    setState(() {
      _createdAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final body = UserBoughtPydantic(
      userId: int.parse(_userIdController.text),
      shopId: int.parse(_shopIdController.text),
      createdAt: _createdAt.toUtc(),
      moneyAmount: _moneyAmountController.text,
    );

    final response = await _restClient.fallback
        .postUserBoughtApiV2LowAdminApiUserBoughtPost(body: body);

    if (!mounted) return;

    if (response.isSuccess) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('添加成功')));
    } else {
      setState(() {
        _isSubmitting = false;
        _errorMessage = response.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return AlertDialog(
      title: const Text('添加购买记录'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 用户ID
                TextFormField(
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    labelText: '用户 ID *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入用户ID';
                    }
                    if (int.tryParse(value) == null) {
                      return '请输入有效的数字';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 商品ID
                TextFormField(
                  controller: _shopIdController,
                  decoration: const InputDecoration(
                    labelText: '商品 ID *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入商品ID';
                    }
                    if (int.tryParse(value) == null) {
                      return '请输入有效的数字';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 金额
                TextFormField(
                  controller: _moneyAmountController,
                  decoration: const InputDecoration(
                    labelText: '金额 *',
                    border: OutlineInputBorder(),
                    helperText: '例如: 10.00',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入金额';
                    }
                    if (double.tryParse(value) == null) {
                      return '请输入有效的金额';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 创建时间
                InkWell(
                  onTap: _selectDateTime,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: '创建时间 *',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      dateFormat.format(_createdAt),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('添加'),
        ),
      ],
    );
  }
}
