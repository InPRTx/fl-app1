import 'package:fl_app1/api/models/admin_user_v.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnUpdate = Future<bool> Function(Map<String, dynamic> data);

class EditableUserV2InfoCard extends StatefulWidget {
  final AdminUserV? userData;
  final OnUpdate onUpdate;

  const EditableUserV2InfoCard({
    super.key,
    required this.userData,
    required this.onUpdate,
  });

  @override
  State<EditableUserV2InfoCard> createState() => _EditableUserV2InfoCardState();
}

class _EditableUserV2InfoCardState extends State<EditableUserV2InfoCard> {
  bool _isEditing = false;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _boolValues = {};
  final Map<String, DateTime> _dateTimeValues = {};

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final localDateTime = dateTime.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    if (widget.userData == null) return;

    final user = widget.userData!;
    _controllers['userName'] = TextEditingController(text: user.userName);
    _controllers['email'] = TextEditingController(text: user.email);
    _controllers['telegramId'] = TextEditingController(
      text: user.telegramId?.toString() ?? '',
    );
    _boolValues['isEnable'] = user.isEnable;
    _boolValues['isEmailVerify'] = user.isEmailVerify;
    _dateTimeValues['userAccountExpireIn'] = user.userAccountExpireIn;
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _toggleEdit() async {
    if (_isEditing) {
      final telegramText = _controllers['telegramId']!.text.trim();
      final data = <String, dynamic>{
        'userName': _controllers['userName']!.text,
        'email': _controllers['email']!.text,
        'telegramId': telegramText.isEmpty ? null : int.tryParse(telegramText),
        'isEnable': _boolValues['isEnable']!,
        'isEmailVerify': _boolValues['isEmailVerify']!,
        'userAccountExpireIn': _dateTimeValues['userAccountExpireIn']!,
      };

      final success = await widget.onUpdate(data);

      if (success) {
        setState(() => _isEditing = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('用户信息修改成功'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('用户信息修改失败'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          _initializeControllers();
          setState(() {});
        }
      }
    } else {
      setState(() => _isEditing = true);
    }
  }

  Future<void> _selectDateTime(String field) async {
    final currentDate = _dateTimeValues[field] ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );

    if (pickedDate != null && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (pickedTime != null) {
        setState(() {
          // 创建本地时间 DateTime（默认就是本地时区）
          _dateTimeValues[field] = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userData == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无用户信息', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    final user = widget.userData!;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  '用户基本信息',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: _toggleEdit,
                  icon: Icon(_isEditing ? Icons.check : Icons.edit, size: 18),
                  label: Text(_isEditing ? '提交' : '修改'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isEditing ? Colors.green : null,
                    foregroundColor: _isEditing ? Colors.white : null,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow('用户 ID', user.id.toString()),
            _buildEditableInfoRow(
              'userName',
              '用户名',
              _controllers['userName']!.text,
            ),
            _buildEditableInfoRow('email', '邮箱', _controllers['email']!.text),
            _buildBoolInfoRow(
              'isEmailVerify',
              '邮箱验证',
              _boolValues['isEmailVerify']!,
            ),
            _buildBoolInfoRow('isEnable', '账户状态', _boolValues['isEnable']!),
            _buildEditableInfoRow(
              'telegramId',
              'Telegram ID',
              _controllers['telegramId']!.text.isEmpty
                  ? '未绑定'
                  : _controllers['telegramId']!.text,
            ),
            _buildInfoRow('注册 IP', user.regIp?.toString() ?? 'N/A'),
            _buildInfoRow('注册时间', _formatDateTime(user.createdAt)),
            _buildDateTimeInfoRow(
              'userAccountExpireIn',
              '账户过期时间',
              _dateTimeValues['userAccountExpireIn']!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontWeight: valueColor != null ? FontWeight.w500 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoRow(String field, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: _controllers[field],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  )
                : Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildBoolInfoRow(String field, String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: _isEditing
                ? Switch(
                    value: _boolValues[field]!,
                    onChanged: (newValue) {
                      setState(() {
                        _boolValues[field] = newValue;
                      });
                    },
                  )
                : Text(
                    _getDisplayText(field, value),
                    style: TextStyle(
                      color: _getValueColor(field, value),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeInfoRow(String field, String label, DateTime value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: _isEditing
                ? InkWell(
                    onTap: () => _selectDateTime(field),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(_formatDateTime(_dateTimeValues[field])),
                    ),
                  )
                : Text(
                    _formatDateTime(value),
                    style: TextStyle(
                      color: value.isBefore(DateTime.now())
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _getDisplayText(String field, bool value) {
    switch (field) {
      case 'isEmailVerify':
        return value ? '已验证' : '未验证';
      case 'isEnable':
        return value ? '启用' : '禁用';
      default:
        return value.toString();
    }
  }

  Color _getValueColor(String field, bool value) {
    switch (field) {
      case 'isEmailVerify':
        return value ? Colors.green : Colors.orange;
      case 'isEnable':
        return value ? Colors.green : Colors.red;
      default:
        return Colors.black;
    }
  }
}
