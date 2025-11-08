import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/helper/format_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableUserOldServiceCardComponent extends StatefulWidget {
  final AdminOldService? serviceData;
  final Future<bool> Function(Map<String, dynamic> data) onUpdate;

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
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final localDateTime = dateTime.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  Future<void> _editTraffic(String title,
      String fieldName,
      int currentValue,) async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) =>
          _TrafficEditDialog(
            title: title,
            initialValue: currentValue,
          ),
    );

    if (result == null) return;

    final data = {fieldName: result};
    final success = await widget.onUpdate(data);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('更新成功')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('更新失败')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.serviceData;

    if (service == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              '暂无服务数据',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      );
    }

    final usedBytes = service.ssUploadSize + service.ssDownloadSize;
    final totalBytes = service.ssBandwidthTotalSize;
    final remainingBytes = totalBytes - usedBytes;
    final usagePercent = totalBytes > 0 ? (usedBytes / totalBytes * 100) : 0.0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 24),
            _buildTrafficProgress(usedBytes, totalBytes, usagePercent),
            const SizedBox(height: 16),
            _buildTrafficDetails(service, usedBytes, remainingBytes),
            const Divider(height: 24),
            _buildServiceInfo(service),
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
            color: Theme
                .of(context)
                .colorScheme
                .primary
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.cloud,
            color: Theme
                .of(context)
                .colorScheme
                .primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            '旧版服务信息',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTrafficProgress(int usedBytes, int totalBytes, double percent) {
    Color progressColor;
    if (percent >= 90) {
      progressColor = Colors.red;
    } else if (percent >= 70) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '流量使用情况',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '${percent.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: progressColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: totalBytes > 0 ? usedBytes / totalBytes : 0,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${formatBytes(usedBytes)} / ${formatBytes(totalBytes)}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildTrafficDetails(AdminOldService service,
      int usedBytes,
      int remainingBytes,) {
    return Column(
      children: [
        _buildEditableTrafficRow(
          Icons.upload,
          '上传流量',
          service.ssUploadSize,
          'ssUploadSize',
        ),
        _buildEditableTrafficRow(
          Icons.download,
          '下载流量',
          service.ssDownloadSize,
          'ssDownloadSize',
        ),
        _buildEditableTrafficRow(
          Icons.data_usage,
          '总流量限制',
          service.ssBandwidthTotalSize,
          'ssBandwidthTotalSize',
        ),
        _buildInfoRow(
          Icons.trending_down,
          '剩余流量',
          formatBytes(remainingBytes),
          valueColor: remainingBytes < 1073741824 ? Colors.red : null,
        ),
        _buildEditableTrafficRow(
          Icons.history,
          '昨日使用',
          service.ssBandwidthYesterdayUsedSize,
          'ssBandwidthYesterdayUsedSize',
        ),
      ],
    );
  }

  Widget _buildServiceInfo(AdminOldService service) {
    return Column(
      children: [
        _buildInfoRow(
          Icons.star,
          '用户等级',
          service.userLevel.toString(),
        ),
        _buildInfoRow(
          Icons.calendar_today,
          '等级过期时间',
          _formatDateTime(service.userLevelExpireIn),
          valueColor: service.userLevelExpireIn.toLocal().isBefore(
              DateTime.now())
              ? Colors.red
              : Colors.green,
        ),
        _buildInfoRow(
          Icons.speed,
          '连接数量',
          service.nodeConnector.toString(),
        ),
        if (service.nodeSpeedLimit != null)
          _buildInfoRow(
            Icons.speed,
            '速度限制',
            service.nodeSpeedLimit.toString(),
            valueColor: Colors.blue,
          ),
        if (service.autoResetBandwidth > 0)
          _buildInfoRow(
            Icons.autorenew,
            '自动重置流量',
            formatBytes(service.autoResetBandwidth.toInt()),
            valueColor: Colors.blue,
          ),
        if (service.autoResetDay > 0)
          _buildInfoRow(
            Icons.event_repeat,
            '自动重置日',
            '每月${service.autoResetDay}日',
            valueColor: Colors.blue,
          ),
        if (service.ssLastUsedTime != null)
          _buildInfoRow(
            Icons.access_time,
            '最后使用时间',
            _formatDateTime(service.ssLastUsedTime),
          ),
        if (service.lastCheckInTime != null)
          _buildInfoRow(
            Icons.check_circle,
            '最后签到时间',
            _formatDateTime(service.lastCheckInTime),
          ),
      ],
    );
  }

  Widget _buildEditableTrafficRow(IconData icon,
      String label,
      int bytes,
      String fieldName,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _editTraffic(label, fieldName, bytes),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatBytes(bytes),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    bytes.toString(),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.edit, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon,
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

class _TrafficEditDialog extends StatefulWidget {
  final String title;
  final int initialValue;

  const _TrafficEditDialog({
    required this.title,
    required this.initialValue,
  });

  @override
  State<_TrafficEditDialog> createState() => _TrafficEditDialogState();
}

class _TrafficEditDialogState extends State<_TrafficEditDialog> {
  late final TextEditingController _humanController;
  late final TextEditingController _rawController;
  bool _isEditingHuman = true;

  @override
  void initState() {
    super.initState();
    _humanController = TextEditingController(
      text: formatBytes(widget.initialValue),
    );
    _rawController = TextEditingController(
      text: widget.initialValue.toString(),
    );
  }

  @override
  void dispose() {
    _humanController.dispose();
    _rawController.dispose();
    super.dispose();
  }

  void _onHumanChanged(String value) {
    if (!_isEditingHuman) return;
    final bytes = parseBytes(value);
    if (bytes != null) {
      _isEditingHuman = false;
      _rawController.text = bytes.toString();
      _isEditingHuman = true;
    }
  }

  void _onRawChanged(String value) {
    if (_isEditingHuman) return;
    final bytes = int.tryParse(value);
    if (bytes != null) {
      _isEditingHuman = true;
      _humanController.text = formatBytes(bytes);
      _isEditingHuman = false;
    }
  }

  void _save() {
    final bytes = int.tryParse(_rawController.text);
    if (bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的数值')),
      );
      return;
    }

    if (bytes < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('数值不能为负数')),
      );
      return;
    }

    Navigator.of(context).pop(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('编辑${widget.title}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _humanController,
              decoration: const InputDecoration(
                labelText: '人类可读格式',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
                helperText: '例: 10.5 GB, 1024 MB',
              ),
              onChanged: _onHumanChanged,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rawController,
              decoration: const InputDecoration(
                labelText: '原始字节数',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
                helperText: '单位: Bytes',
              ),
              keyboardType: TextInputType.number,
              onChanged: _onRawChanged,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 16,
                          color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        '支持的单位',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'B, KB, MB, GB, TB, PB',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '两种输入框会自动同步转换',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
        ElevatedButton(
          onPressed: _save,
          child: const Text('保存'),
        ),
      ],
    );
  }
}

