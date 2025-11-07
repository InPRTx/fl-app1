import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/service/auth/auth_export.dart';
import 'package:flutter/material.dart';

class LowAdminUserMoneyRechargePage extends StatefulWidget {
  final int userId;

  const LowAdminUserMoneyRechargePage({super.key, required this.userId});

  @override
  State<LowAdminUserMoneyRechargePage> createState() =>
      _LowAdminUserMoneyRechargePageState();
}

class _LowAdminUserMoneyRechargePageState
    extends State<LowAdminUserMoneyRechargePage> {
  late final RestClient _restClient = createAuthenticatedClient();

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _remarkController = TextEditingController();
  bool _isInsertPaylist = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _submitRecharge() async {
    setState(() => _isSubmitting = true);

    final inputText = _amountController.text.trim();

    if (inputText.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ 请输入充值金额'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
      setState(() => _isSubmitting = false);
      return;
    }

    final amount = double.tryParse(inputText);
    if (amount == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ 输入格式错误：「$inputText」不是有效的数字'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() => _isSubmitting = false);
      return;
    }

    if (amount == 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ 金额不能为0，请输入正数充值或负数扣费'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
      setState(() => _isSubmitting = false);
      return;
    }

    final body =
        WebSubFastapiRoutersApiVLowAdminApiUserMoneyMoneyRechargeItParamsModel(
          moneyAmountAdd: amount,
          isInsertPaylist: _isInsertPaylist,
          remark: _remarkController.text.trim().isEmpty
              ? null
              : _remarkController.text.trim(),
        );

    final response = await _restClient.fallback
        .postUserMoneyMoneyRechargeItApiV2LowAdminApiUserMoneyMoneyRechargeItUserIdPost(
          userId: widget.userId,
          body: body,
        );

    setState(() => _isSubmitting = false);

    if (mounted) {
      if (response.isSuccess == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('充值成功'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('充值失败: ${response.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户充值 - ID: ${widget.userId}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '充值信息',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: '充值金额',
                      hintText: '请输入充值金额（支持负数扣费）',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      helperText: '正数为充值，负数为扣费',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _remarkController,
                    decoration: const InputDecoration(
                      labelText: '备注（可选）',
                      hintText: '请输入备注信息',
                      prefixIcon: Icon(Icons.note),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    maxLength: 200,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('显示在充值记录'),
                    subtitle: const Text('是否将此次充值显示在用户的充值记录中'),
                    value: _isInsertPaylist,
                    onChanged: (value) {
                      setState(() => _isInsertPaylist = value);
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _isSubmitting ? null : _submitRecharge,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.check),
                      label: Text(_isSubmitting ? '充值中...' : '确认充值'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
