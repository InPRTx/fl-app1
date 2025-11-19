import 'package:fl_app1/api/export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableUserV2InfoCardComponent extends StatefulWidget {
  final AdminUserV? userData;
  final Future<bool> Function(Map<String, dynamic> data) onUpdate;

  const EditableUserV2InfoCardComponent({
    super.key,
    required this.userData,
    required this.onUpdate,
  });

  @override
  State<EditableUserV2InfoCardComponent> createState() =>
      _EditableUserV2InfoCardComponentState();
}

class _EditableUserV2InfoCardComponentState
    extends State<EditableUserV2InfoCardComponent> {
  bool _isEditing = false;
  bool _isSaving = false;

  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _tgIdController;
  late bool _isEnabled;
  late bool _isEmailVerify;
  late DateTime _userAccountExpireIn;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _tgIdController = TextEditingController();
    _initializeControllers();
  }

  void _initializeControllers() {
    final user = widget.userData;
    _emailController.text = user?.email ?? '';
    _userNameController.text = user?.userName ?? '';
    _tgIdController.text = user?.tgId?.toString() ?? '';
    _isEnabled = user?.isEnabled ?? true;
    _isEmailVerify = user?.isEmailVerify ?? false;
    // API 返回的是 UTC 时间，转换为本地时间供编辑使用
    _userAccountExpireIn =
        user?.userAccountExpireIn.toLocal() ??
        DateTime.now().add(const Duration(days: 365));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _tgIdController.dispose();
    super.dispose();
  }

  Future<void> _toggleEdit() async {
    if (_isEditing) {
      setState(() => _isSaving = true);

      final data = {
        'email': _emailController.text.trim(),
        'userName': _userNameController.text.trim(),
        'isEnabled': _isEnabled,
        'isEmailVerify': _isEmailVerify,
        'userAccountExpireIn': _userAccountExpireIn,
        'tgId': _tgIdController.text.trim().isEmpty
            ? null
            : int.tryParse(_tgIdController.text.trim()),
      };

      final success = await widget.onUpdate(data);

      if (mounted) {
        setState(() {
          _isSaving = false;
          if (success) {
            _isEditing = false;
          }
        });

        if (success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('更新成功')));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('更新失败')));
        }
      }
    } else {
      setState(() => _isEditing = true);
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _initializeControllers();
    });
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _userAccountExpireIn,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_userAccountExpireIn),
    );

    if (time == null) return;

    setState(() {
      _userAccountExpireIn = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final localDateTime = dateTime.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userData;

    if (user == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无用户数据', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 24),
            _buildContent(user),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            '用户基本信息',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        if (!_isEditing)
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: _toggleEdit,
            tooltip: '编辑',
          ),
        if (_isEditing) ...[
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: _isSaving ? null : _cancelEdit,
            tooltip: '取消',
          ),
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check, size: 20),
            onPressed: _isSaving ? null : _toggleEdit,
            tooltip: '保存',
          ),
        ],
      ],
    );
  }

  Widget _buildContent(AdminUserV user) {
    if (_isEditing) {
      return Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: '邮箱',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _userNameController,
            decoration: const InputDecoration(
              labelText: '用户名',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _tgIdController,
            decoration: const InputDecoration(
              labelText: 'Telegram ID',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.telegram),
            ),
            keyboardType: TextInputType.number,
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('账号启用状态'),
            subtitle: Text(_isEnabled ? '已启用' : '已禁用'),
            value: _isEnabled,
            onChanged: _isSaving
                ? null
                : (value) => setState(() => _isEnabled = value),
          ),
          SwitchListTile(
            title: const Text('邮箱验证状态'),
            subtitle: Text(_isEmailVerify ? '已验证' : '未验证'),
            value: _isEmailVerify,
            onChanged: _isSaving
                ? null
                : (value) => setState(() => _isEmailVerify = value),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _isSaving ? null : _selectDateTime,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: '账号过期时间',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              child: Text(
                _formatDateTime(_userAccountExpireIn),
                style: TextStyle(
                  color: _userAccountExpireIn.isBefore(DateTime.now())
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        _buildInfoRow(Icons.fingerprint, '用户ID', user.id.toString()),
        _buildInfoRow(Icons.email, '邮箱', user.email),
        _buildInfoRow(Icons.person_outline, '用户名', user.userName),
        if (user.tgId != null)
          _buildInfoRow(Icons.telegram, 'Telegram ID', user.tgId.toString()),
        _buildInfoRow(
          Icons.power_settings_new,
          '账号状态',
          user.isEnabled ? '已启用' : '已禁用',
          valueColor: user.isEnabled ? Colors.green : Colors.red,
        ),
        _buildInfoRow(
          Icons.verified,
          '邮箱验证',
          user.isEmailVerify ? '已验证' : '未验证',
          valueColor: user.isEmailVerify ? Colors.green : Colors.orange,
        ),
        _buildInfoRow(
          Icons.calendar_today,
          '账号过期时间',
          _formatDateTime(user.userAccountExpireIn),
          valueColor:
              user.userAccountExpireIn.toLocal().isBefore(DateTime.now())
              ? Colors.red
              : Colors.green,
        ),
        _buildInfoRow(
          Icons.access_time,
          '创建时间',
          _formatDateTime(user.createdAt),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
