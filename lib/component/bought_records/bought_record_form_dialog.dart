import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// 编辑/添加购买记录对话框
class BoughtRecordFormDialog extends StatefulWidget {
  final WebSubFastapiRoutersApiVLowAdminApiUserBoughtGetUserBoughtResponseResultListData?
  record;
  final int? presetUserId;

  const BoughtRecordFormDialog({super.key, this.record, this.presetUserId});

  @override
  State<BoughtRecordFormDialog> createState() => _BoughtRecordFormDialogState();
}

class _BoughtRecordFormDialogState extends State<BoughtRecordFormDialog> {
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

    if (widget.record != null) {
      // 编辑模式
      _userIdController = TextEditingController(
        text: widget.record!.userId.toString(),
      );
      _shopIdController = TextEditingController(
        text: widget.record!.shopId.toString(),
      );
      _moneyAmountController = TextEditingController(
        text: widget.record!.moneyAmount,
      );
      _createdAt = widget.record!.createdAt.toLocal();
    } else {
      // 添加模式
      _userIdController = TextEditingController(
        text: widget.presetUserId?.toString() ?? '',
      );
      _shopIdController = TextEditingController();
      _moneyAmountController = TextEditingController();
      _createdAt = DateTime.now();
    }
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
      userId: widget.record != null
          ? widget.record!.userId
          : int.parse(_userIdController.text),
      shopId: int.parse(_shopIdController.text),
      createdAt: _createdAt.toUtc(),
      moneyAmount: _moneyAmountController.text,
    );

    ErrorResponse response;
    if (widget.record != null) {
      // 更新
      response = await _restClient.fallback
          .putUserBoughtApiV2LowAdminApiUserBoughtBoughtIdPut(
            boughtId: widget.record!.id,
            body: body,
          );
    } else {
      // 添加 - API 暂时不支持 POST，显示错误
      setState(() {
        _isSubmitting = false;
        _errorMessage = 'API 暂不支持添加购买记录功能';
      });
      return;
    }

    if (!mounted) return;

    if (response.isSuccess) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _isSubmitting = false;
        _errorMessage = response.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.record != null;
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return AlertDialog(
      title: Text(isEditMode ? '编辑购买记录' : '添加购买记录'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isEditMode)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'ID: ${widget.record!.id}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),

                // 用户ID
                TextFormField(
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    labelText: '用户 ID *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  enabled: !isEditMode,
                  // 编辑模式下不允许修改用户ID
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

                if (isEditMode && widget.record!.shopName.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      '商品名称: ${widget.record!.shopName}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
              : Text(isEditMode ? '更新' : '添加'),
        ),
      ],
    );
  }
}
