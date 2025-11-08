import 'package:fl_app1/api/models/admin_old_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

typedef OnUpdateOldService = Future<bool> Function(Map<String, dynamic> data);

class EditableUserOldServiceCardComponent extends StatefulWidget {
  final AdminOldService? serviceData;
  final OnUpdateOldService onUpdate;

  const EditableUserOldServiceCardComponent({
    super.key,
    required this.serviceData,
    required this.onUpdate,
  });

  @override
  State<EditableUserOldServiceCardComponent> createState() =>
      _EditableUserOldServiceCardComponentState();
}

class _EditableUserOldServiceCardComponentState
    extends State<EditableUserOldServiceCardComponent> {
  bool _isEditing = false;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _boolValues = {};
  final Map<String, DateTime> _dateTimeValues = {};

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final tz.TZDateTime localDateTime = tz.TZDateTime.from(dateTime, tz.local);
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

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    if (widget.serviceData == null) return;

    final service = widget.serviceData!;

    // 初始化文本字段控制器
    _controllers['ssBandwidthTotalSize'] = TextEditingController(
      text: service.ssBandwidthTotalSize.toString(),
    );
    _controllers['userLevel'] = TextEditingController(
      text: service.userLevel.toString(),
    );
    _controllers['nodeConnector'] = TextEditingController(
      text: service.nodeConnector.toString(),
    );
    _controllers['autoResetDay'] = TextEditingController(
      text: service.autoResetDay.toString(),
    );
    _controllers['autoResetBandwidth'] = TextEditingController(
      text: service.autoResetBandwidth.toString(),
    );
    if (service.nodeSpeedLimit != null) {
      _controllers['nodeSpeedLimit'] = TextEditingController(
        text: service.nodeSpeedLimit.toString(),
      );
    }

    // 初始化日期时间 - 转换为本地时间
    _dateTimeValues['userLevelExpireIn'] =
        tz.TZDateTime.from(service.userLevelExpireIn, tz.local);
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _toggleEdit() async {
    if (_isEditing) {
      // 保存逻辑
      final data = <String, dynamic>{
        'ssBandwidthTotalSize':
            int.tryParse(_controllers['ssBandwidthTotalSize']!.text) ?? 0,
        'userLevel': int.tryParse(_controllers['userLevel']!.text) ?? 0,
        'nodeConnector': int.tryParse(_controllers['nodeConnector']!.text) ?? 0,
        'autoResetDay': int.tryParse(_controllers['autoResetDay']!.text) ?? 0,
        'autoResetBandwidth':
            num.tryParse(_controllers['autoResetBandwidth']!.text) ?? 0.0,
        'userLevelExpireIn': _dateTimeValues['userLevelExpireIn']!
            .toUtc(), // 转换为UTC时间
      };

      if (_controllers.containsKey('nodeSpeedLimit')) {
        data['nodeSpeedLimit'] = int.tryParse(
          _controllers['nodeSpeedLimit']!.text,
        );
      }

      final success = await widget.onUpdate(data);
      if (success && mounted) {
        setState(() => _isEditing = false);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('更新成功')));
        }
      } else if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('更新失败')));
      }
    } else {
      setState(() => _isEditing = true);
    }
  }

  Future<void> _selectDateTime(String field) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final initialDate = _dateTimeValues[field] ?? now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );

    if (pickedDate != null && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null && mounted) {
        setState(() {
          // 使用 tz.TZDateTime 创建本地时区的时间
          _dateTimeValues[field] = tz.TZDateTime(
            tz.local,
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
    final totalBytes = service.ssBandwidthTotalSize;
    final usagePercent = totalBytes > 0
        ? (usedBytes / totalBytes).clamp(0.0, 1.0)
        : 0.0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cloud, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  '旧版服务信息',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                  onPressed: _toggleEdit,
                  tooltip: _isEditing ? '保存' : '编辑',
                ),
                if (_isEditing)
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                        _initializeControllers();
                      });
                    },
                    tooltip: '取消',
                  ),
              ],
            ),
            const Divider(height: 24),

            // 流量使用进度条
            _buildProgressBar(context, usagePercent, usedBytes, totalBytes),
            const SizedBox(height: 16),

            // 流量统计信息
            _buildInfoRow('上传流量', _formatBytes(service.ssUploadSize), null),
            _buildInfoRow('下载流量', _formatBytes(service.ssDownloadSize), null),
            _buildInfoRow(
              '总流量',
              _formatBytes(service.ssBandwidthTotalSize),
              'ssBandwidthTotalSize',
            ),
            _buildInfoRow(
              '昨日使用',
              _formatBytes(service.ssBandwidthYesterdayUsedSize),
              null,
            ),

            const Divider(height: 24),

            // 用户信息
            _buildInfoRow('用户等级', 'Level ${service.userLevel}', 'userLevel'),
            _buildDateTimeInfoRow(
              '等级过期时间',
              'userLevelExpireIn',
              service.userLevelExpireIn,
            ),
            _buildInfoRow(
              '在线设备数',
              service.nodeConnector.toString(),
              'nodeConnector',
            ),
            _buildInfoRow(
              '节点速率限制',
              service.nodeSpeedLimit != null
                  ? '${service.nodeSpeedLimit} Mbps'
                  : '无限制',
              service.nodeSpeedLimit != null ? 'nodeSpeedLimit' : null,
            ),

            const Divider(height: 24),

            // 自动重置设置
            _buildInfoRow(
              '自动重置日',
              service.autoResetDay.toString(),
              'autoResetDay',
            ),
            _buildInfoRow(
              '重置流量值',
              _formatBytes(service.autoResetBandwidth.toInt()),
              'autoResetBandwidth',
            ),

            const Divider(height: 24),

            // 时间信息
            _buildInfoRow(
              '最后使用时间',
              _formatDateTime(service.ssLastUsedTime),
              null,
            ),
            _buildInfoRow(
              '最后签到时间',
              _formatDateTime(service.lastCheckInTime),
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context,
    double percent,
    int used,
    int total,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('流量使用', style: Theme.of(context).textTheme.titleMedium),
            Text(
              '${(percent * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color: percent > 0.8 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percent,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            percent > 0.8 ? Colors.red : Colors.green,
          ),
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Text(
          '${_formatBytes(used)} / ${_formatBytes(total)}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, String? fieldKey) {
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
            child:
                _isEditing &&
                    fieldKey != null &&
                    _controllers.containsKey(fieldKey)
                ? TextField(
                    controller: _controllers[fieldKey],
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType:
                        fieldKey == 'ssPassword' || fieldKey == 'ssMethod'
                        ? TextInputType.text
                        : TextInputType.number,
                  )
                : Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeInfoRow(String label, String field, DateTime value) {
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _formatDateTime(_dateTimeValues[field]),
                            ),
                          ),
                          const Icon(Icons.calendar_today, size: 16),
                        ],
                      ),
                    ),
                  )
                : Text(
                    _formatDateTime(value),
                    style: TextStyle(
                      color: value.isBefore(tz.TZDateTime.now(tz.local))
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
