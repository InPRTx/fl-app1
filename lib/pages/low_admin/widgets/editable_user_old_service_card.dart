import 'package:fl_app1/api/models/admin_old_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnFieldUpdate = Future<bool> Function(String field, dynamic value);

class EditableUserOldServiceCard extends StatefulWidget {
  final AdminOldService? serviceData;
  final OnFieldUpdate onFieldUpdate;

  const EditableUserOldServiceCard({
    super.key,
    required this.serviceData,
    required this.onFieldUpdate,
  });

  @override
  State<EditableUserOldServiceCard> createState() =>
      _EditableUserOldServiceCardState();
}

class _EditableUserOldServiceCardState
    extends State<EditableUserOldServiceCard> {
  final Map<String, bool> _editingFields = {};
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, TextEditingController> _rawControllers = {};
  final Map<String, DateTime> _dateTimeValues = {};

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final localDateTime = dateTime.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  int _parseBytes(String text) {
    final regex = RegExp(r'([\d.]+)\s*([KMGT]?B)');
    final match = regex.firstMatch(text.toUpperCase());
    if (match == null) return 0;

    final value = double.tryParse(match.group(1) ?? '0') ?? 0;
    final unit = match.group(2);

    switch (unit) {
      case 'B':
        return value.toInt();
      case 'KB':
        return (value * 1024).toInt();
      case 'MB':
        return (value * 1024 * 1024).toInt();
      case 'GB':
        return (value * 1024 * 1024 * 1024).toInt();
      case 'TB':
        return (value * 1024 * 1024 * 1024 * 1024).toInt();
      default:
        return value.toInt();
    }
  }

  double _calculateUsagePercent() {
    if (widget.serviceData == null ||
        widget.serviceData!.ssBandwidthTotalSize == 0) {
      return 0.0;
    }
    final used =
        widget.serviceData!.ssUploadSize + widget.serviceData!.ssDownloadSize;
    return (used / widget.serviceData!.ssBandwidthTotalSize).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    if (widget.serviceData == null) return;

    final service = widget.serviceData!;

    // 初始化带宽字段的双控制器（人类可读 + 原始数字）
    _initBandwidthControllers('ssUploadSize', service.ssUploadSize);
    _initBandwidthControllers('ssDownloadSize', service.ssDownloadSize);
    _initBandwidthControllers(
      'ssBandwidthTotalSize',
      service.ssBandwidthTotalSize,
    );
    _initBandwidthControllers(
      'ssBandwidthYesterdayUsedSize',
      service.ssBandwidthYesterdayUsedSize,
    );
    _initBandwidthControllers(
      'autoResetBandwidth',
      service.autoResetBandwidth.toInt(),
    );

    // 初始化节点速率限制的双控制器（Mbps + 原始字节）
    // 即使为空也初始化，确保编辑时可以正常同步
    _initSpeedLimitControllers('nodeSpeedLimit', service.nodeSpeedLimit ?? 0);

    _controllers['userLevel'] = TextEditingController(
      text: service.userLevel.toString(),
    );
    _controllers['nodeConnector'] = TextEditingController(
      text: service.nodeConnector.toString(),
    );
    _controllers['autoResetDay'] = TextEditingController(
      text: service.autoResetDay.toString(),
    );
    // 从 UTC 转换为本地时间用于显示和编辑
    _dateTimeValues['userLevelExpireIn'] = service.userLevelExpireIn.toLocal();
  }

  void _initBandwidthControllers(String field, int bytes) {
    // 人类可读格式控制器
    _controllers[field] = TextEditingController(text: _formatBytes(bytes));
    // 原始数字控制器
    _rawControllers[field] = TextEditingController(text: bytes.toString());

    // 添加监听器：人类可读 -> 原始数字
    _controllers[field]!.addListener(() {
      if (_editingFields[field] == true) {
        final parsed = _parseBytes(_controllers[field]!.text);
        if (_rawControllers[field]!.text != parsed.toString()) {
          final rawStr = parsed.toString();
          final currentRawSelection = _rawControllers[field]!.selection;
          _rawControllers[field]!.value = TextEditingValue(
            text: rawStr,
            selection: currentRawSelection.baseOffset <= rawStr.length
                ? currentRawSelection
                : TextSelection.collapsed(offset: rawStr.length),
          );
        }
      }
    });

    // 添加监听器：原始数字 -> 人类可读
    _rawControllers[field]!.addListener(() {
      if (_editingFields[field] == true) {
        final rawValue = int.tryParse(_rawControllers[field]!.text) ?? 0;
        final formatted = _formatBytes(rawValue);
        if (_controllers[field]!.text != formatted) {
          final currentHumanSelection = _controllers[field]!.selection;
          _controllers[field]!.value = TextEditingValue(
            text: formatted,
            selection: currentHumanSelection.baseOffset <= formatted.length
                ? currentHumanSelection
                : TextSelection.collapsed(offset: formatted.length),
          );
        }
      }
    });
  }

  void _initSpeedLimitControllers(String field, int bytesValue) {
    // Mbps 格式控制器 (bytesValue / 1073741824 = Mbps)
    // 如果值为0，初始化为空字符串
    final mbps = bytesValue > 0
        ? (bytesValue / 1073741824).toStringAsFixed(2)
        : '';
    _controllers[field] = TextEditingController(text: mbps);
    // 原始字节控制器
    _rawControllers[field] = TextEditingController(
      text: bytesValue > 0 ? bytesValue.toString() : '',
    );

    // 添加监听器：Mbps -> 原始字节
    _controllers[field]!.addListener(() {
      if (_editingFields[field] == true) {
        final text = _controllers[field]!.text.trim();
        if (text.isEmpty) {
          if (_rawControllers[field]!.text != '') {
            _rawControllers[field]!.value = const TextEditingValue(
              text: '',
              selection: TextSelection.collapsed(offset: 0),
            );
          }
        } else {
          final mbpsValue = double.tryParse(text) ?? 0;
          final bytes = (mbpsValue * 1073741824).toInt();
          final bytesStr = bytes.toString();
          if (_rawControllers[field]!.text != bytesStr) {
            final currentRawSelection = _rawControllers[field]!.selection;
            _rawControllers[field]!.value = TextEditingValue(
              text: bytesStr,
              selection: currentRawSelection.baseOffset <= bytesStr.length
                  ? currentRawSelection
                  : TextSelection.collapsed(offset: bytesStr.length),
            );
          }
        }
      }
    });

    // 添加监听器：原始字节 -> Mbps
    _rawControllers[field]!.addListener(() {
      if (_editingFields[field] == true) {
        final text = _rawControllers[field]!.text.trim();
        if (text.isEmpty) {
          if (_controllers[field]!.text != '') {
            _controllers[field]!.value = const TextEditingValue(
              text: '',
              selection: TextSelection.collapsed(offset: 0),
            );
          }
        } else {
          final rawValue = int.tryParse(text) ?? 0;
          final mbpsValue = (rawValue / 1073741824).toStringAsFixed(2);
          if (_controllers[field]!.text != mbpsValue) {
            final currentHumanSelection = _controllers[field]!.selection;
            _controllers[field]!.value = TextEditingValue(
              text: mbpsValue,
              selection: currentHumanSelection.baseOffset <= mbpsValue.length
                  ? currentHumanSelection
                  : TextSelection.collapsed(offset: mbpsValue.length),
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    for (var controller in _rawControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _toggleEdit(String field) async {
    if (_editingFields[field] == true) {
      setState(() {
        _editingFields[field] = false;
      });

      dynamic value;
      if (_dateTimeValues.containsKey(field)) {
        value = _dateTimeValues[field];
      } else if (_rawControllers.containsKey(field)) {
        // 使用原始数字控制器的值
        value = int.tryParse(_rawControllers[field]!.text) ?? 0;
      } else if (_controllers.containsKey(field)) {
        final text = _controllers[field]!.text;
        if (field == 'nodeSpeedLimit' && text.isEmpty) {
          value = null;
        } else {
          value = int.tryParse(text) ?? 0;
        }
      }

      final success = await widget.onFieldUpdate(field, value);

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('数据修改成功: $field'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('数据修改失败: $field'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          _initializeControllers();
          setState(() {});
        }
      }
    } else {
      setState(() {
        _editingFields[field] = true;
      });
    }
  }

  Future<void> _selectDateTime(String field) async {
    final currentDate = _dateTimeValues[field] ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (pickedTime != null) {
        setState(() {
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
    if (widget.serviceData == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无服务信息', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    final service = widget.serviceData!;
    final usedBytes = service.ssUploadSize + service.ssDownloadSize;
    final usagePercent = _calculateUsagePercent();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cloud_circle, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  '服务信息',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '流量使用情况',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${(usagePercent * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: usagePercent > 0.9 ? Colors.red : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: usagePercent,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      usagePercent > 0.9
                          ? Colors.red
                          : usagePercent > 0.7
                          ? Colors.orange
                          : Colors.blue,
                    ),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '已用: ${_formatBytes(usedBytes)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        '总量: ${_formatBytes(service.ssBandwidthTotalSize)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildDualBandwidthRow(
              'ssUploadSize',
              '上传流量',
              service.ssUploadSize,
            ),
            _buildDualBandwidthRow(
              'ssDownloadSize',
              '下载流量',
              service.ssDownloadSize,
            ),
            _buildDualBandwidthRow(
              'ssBandwidthTotalSize',
              '总流量',
              service.ssBandwidthTotalSize,
            ),
            _buildDualBandwidthRow(
              'ssBandwidthYesterdayUsedSize',
              '昨日使用',
              service.ssBandwidthYesterdayUsedSize,
            ),
            _buildEditableInfoRow(
              'userLevel',
              '用户等级',
              'Level ${service.userLevel}',
            ),
            _buildDateTimeInfoRow(
              'userLevelExpireIn',
              '等级过期时间',
              _dateTimeValues['userLevelExpireIn']!,
            ),
            _buildInfoRow('最后使用时间', _formatDateTime(service.ssLastUsedTime)),
            _buildInfoRow('最后签到时间', _formatDateTime(service.lastCheckInTime)),
            _buildEditableInfoRow(
              'nodeConnector',
              '在线设备数',
              service.nodeConnector.toString(),
            ),
            _buildDualSpeedLimitRow(
              'nodeSpeedLimit',
              '节点速率限制',
              service.nodeSpeedLimit,
            ),
            _buildEditableInfoRow(
              'autoResetDay',
              '自动重置日',
              service.autoResetDay > 0 ? '每月 ${service.autoResetDay} 日' : '未设置',
            ),
            _buildDualBandwidthRow(
              'autoResetBandwidth',
              '重置流量值',
              service.autoResetBandwidth.toInt(),
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
    final isEditing = _editingFields[field] ?? false;

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
            child: isEditing
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
                    keyboardType:
                        field.contains('Size') ||
                            field.contains('Level') ||
                            field.contains('Connector') ||
                            field.contains('Day')
                        ? TextInputType.number
                        : TextInputType.text,
                  )
                : Text(value),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, size: 20),
            onPressed: () => _toggleEdit(field),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeInfoRow(String field, String label, DateTime value) {
    final isEditing = _editingFields[field] ?? false;

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
            child: isEditing
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
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, size: 20),
            onPressed: () => _toggleEdit(field),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDualBandwidthRow(String field, String label, int bytes) {
    final isEditing = _editingFields[field] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                child: isEditing
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controllers[field],
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: '人类可读',
                                    hintText: '如: 1.5 GB',
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _rawControllers[field],
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: '原始字节',
                                    hintText: '如: 1073741824',
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_formatBytes(bytes)),
                          Text(
                            '(原始: $bytes 字节)',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
              ),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit, size: 20),
                onPressed: () => _toggleEdit(field),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDualSpeedLimitRow(String field, String label, int? bytesValue) {
    final isEditing = _editingFields[field] ?? false;
    final hasValue = bytesValue != null && bytesValue > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                child: isEditing
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controllers[field],
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Mbps',
                                    hintText: '如: 100.00',
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _rawControllers[field],
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: '原始字节',
                                    hintText: '如: 107374182400',
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '注: 由于技术限制，最低限制为无限制(0)或1Mbps',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hasValue
                                ? '${(bytesValue / 1073741824).toStringAsFixed(2)} Mbps'
                                : '无限制',
                          ),
                          if (hasValue)
                            Text(
                              '(原始: $bytesValue 字节)',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
              ),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit, size: 20),
                onPressed: () => _toggleEdit(field),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
