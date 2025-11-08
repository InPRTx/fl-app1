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
  bool _isEditing = false;
  bool _isSaving = false;

  late final TextEditingController _ssUploadSizeHumanController;
  late final TextEditingController _ssUploadSizeRawController;
  late final TextEditingController _ssDownloadSizeHumanController;
  late final TextEditingController _ssDownloadSizeRawController;
  late final TextEditingController _ssBandwidthTotalSizeHumanController;
  late final TextEditingController _ssBandwidthTotalSizeRawController;
  late final TextEditingController _ssBandwidthYesterdayUsedSizeHumanController;
  late final TextEditingController _ssBandwidthYesterdayUsedSizeRawController;
  late final TextEditingController _userLevelController;
  late final TextEditingController _nodeSpeedLimitRawController;
  late final TextEditingController _nodeConnectorController;
  late final TextEditingController _autoResetDayController;
  late final TextEditingController _autoResetBandwidthHumanController;
  late final TextEditingController _autoResetBandwidthRawController;

  late DateTime? _userLevelExpireIn;

  @override
  void initState() {
    super.initState();
    _ssUploadSizeHumanController = TextEditingController();
    _ssUploadSizeRawController = TextEditingController();
    _ssDownloadSizeHumanController = TextEditingController();
    _ssDownloadSizeRawController = TextEditingController();
    _ssBandwidthTotalSizeHumanController = TextEditingController();
    _ssBandwidthTotalSizeRawController = TextEditingController();
    _ssBandwidthYesterdayUsedSizeHumanController = TextEditingController();
    _ssBandwidthYesterdayUsedSizeRawController = TextEditingController();
    _userLevelController = TextEditingController();
    _nodeSpeedLimitRawController = TextEditingController();
    _nodeConnectorController = TextEditingController();
    _autoResetDayController = TextEditingController();
    _autoResetBandwidthHumanController = TextEditingController();
    _autoResetBandwidthRawController = TextEditingController();
    _initializeControllers();
  }

  @override
  void dispose() {
    _ssUploadSizeHumanController.dispose();
    _ssUploadSizeRawController.dispose();
    _ssDownloadSizeHumanController.dispose();
    _ssDownloadSizeRawController.dispose();
    _ssBandwidthTotalSizeHumanController.dispose();
    _ssBandwidthTotalSizeRawController.dispose();
    _ssBandwidthYesterdayUsedSizeHumanController.dispose();
    _ssBandwidthYesterdayUsedSizeRawController.dispose();
    _userLevelController.dispose();
    _nodeSpeedLimitRawController.dispose();
    _nodeConnectorController.dispose();
    _autoResetDayController.dispose();
    _autoResetBandwidthHumanController.dispose();
    _autoResetBandwidthRawController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    final service = widget.serviceData;
    _ssUploadSizeHumanController.text = formatBytes(service?.ssUploadSize ?? 0);
    _ssUploadSizeRawController.text = (service?.ssUploadSize ?? 0).toString();
    _ssDownloadSizeHumanController.text = formatBytes(
      service?.ssDownloadSize ?? 0,
    );
    _ssDownloadSizeRawController.text = (service?.ssDownloadSize ?? 0)
        .toString();
    _ssBandwidthTotalSizeHumanController.text = formatBytes(
      service?.ssBandwidthTotalSize ?? 0,
    );
    _ssBandwidthTotalSizeRawController.text =
        (service?.ssBandwidthTotalSize ?? 0).toString();
    _ssBandwidthYesterdayUsedSizeHumanController.text = formatBytes(
      service?.ssBandwidthYesterdayUsedSize ?? 0,
    );
    _ssBandwidthYesterdayUsedSizeRawController.text =
        (service?.ssBandwidthYesterdayUsedSize ?? 0).toString();
    _userLevelController.text = (service?.userLevel ?? 0).toString();

    // node_speed_limit 现在是 Mbps，直接显示
    final speedLimitMbps = service?.nodeSpeedLimit;
    _nodeSpeedLimitRawController.text = speedLimitMbps?.toString() ?? '';

    _nodeConnectorController.text = (service?.nodeConnector ?? 0).toString();

    // auto_reset_day 可能为 null，显示为空字符串
    _autoResetDayController.text = service?.autoResetDay?.toString() ?? '';

    // auto_reset_bandwidth 可能为 null，类型为 String?
    final resetBandwidth = service?.autoResetBandwidth;
    if (resetBandwidth != null && resetBandwidth.isNotEmpty) {
      final bandwidthValue = num.tryParse(resetBandwidth);
      if (bandwidthValue != null) {
        _autoResetBandwidthHumanController.text = formatBytes(
          bandwidthValue.toInt(),
        );
        _autoResetBandwidthRawController.text = bandwidthValue
            .toInt()
            .toString();
      } else {
        _autoResetBandwidthHumanController.text = '';
        _autoResetBandwidthRawController.text = '';
      }
    } else {
      _autoResetBandwidthHumanController.text = '';
      _autoResetBandwidthRawController.text = '';
    }

    _userLevelExpireIn = service?.userLevelExpireIn.toLocal();
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final localDateTime = dateTime.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  void _syncTrafficControllers(
    TextEditingController humanController,
    TextEditingController rawController,
    String value,
    bool isHumanEditing,
  ) {
    if (isHumanEditing) {
      final bytes = parseBytes(value);
      if (bytes != null) {
        rawController.text = bytes.toString();
      }
    } else {
      final bytes = int.tryParse(value);
      if (bytes != null) {
        humanController.text = formatBytes(bytes);
      }
    }
  }

  Future<void> _toggleEdit() async {
    if (_isEditing) {
      setState(() => _isSaving = true);

      final data = <String, dynamic>{
        'ssUploadSize': int.tryParse(_ssUploadSizeRawController.text) ?? 0,
        'ssDownloadSize': int.tryParse(_ssDownloadSizeRawController.text) ?? 0,
        'ssBandwidthTotalSize':
            int.tryParse(_ssBandwidthTotalSizeRawController.text) ?? 0,
        'ssBandwidthYesterdayUsedSize':
            int.tryParse(_ssBandwidthYesterdayUsedSizeRawController.text) ?? 0,
        'userLevel': int.tryParse(_userLevelController.text) ?? 0,
        'userLevelExpireIn': _userLevelExpireIn,
        // node_speed_limit 现在是 Mbps (num 类型)，支持小数
        'nodeSpeedLimit': _nodeSpeedLimitRawController.text.trim().isEmpty
            ? null
            : num.tryParse(_nodeSpeedLimitRawController.text),
        'nodeConnector': int.tryParse(_nodeConnectorController.text) ?? 0,
        // auto_reset_day 空值为 null
        'autoResetDay': _autoResetDayController.text.trim().isEmpty
            ? null
            : int.tryParse(_autoResetDayController.text),
        // auto_reset_bandwidth 空值为 null
        'autoResetBandwidth':
            _autoResetBandwidthRawController.text.trim().isEmpty
            ? null
            : int.tryParse(_autoResetBandwidthRawController.text),
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
      initialDate: _userLevelExpireIn ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_userLevelExpireIn ?? DateTime.now()),
    );

    if (time == null) return;

    setState(() {
      _userLevelExpireIn = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.serviceData;

    if (service == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无服务数据', style: TextStyle(color: Colors.grey[600])),
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
            _buildContent(service),
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
            Icons.cloud,
            color: Theme.of(context).colorScheme.primary,
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

  Widget _buildContent(AdminOldService service) {
    if (_isEditing) {
      return Column(
        children: [
          _buildTrafficEditSection(
            '上传流量',
            _ssUploadSizeHumanController,
            _ssUploadSizeRawController,
            Icons.upload,
          ),
          const SizedBox(height: 12),
          _buildTrafficEditSection(
            '下载流量',
            _ssDownloadSizeHumanController,
            _ssDownloadSizeRawController,
            Icons.download,
          ),
          const SizedBox(height: 12),
          _buildTrafficEditSection(
            '总流量限制',
            _ssBandwidthTotalSizeHumanController,
            _ssBandwidthTotalSizeRawController,
            Icons.data_usage,
          ),
          const SizedBox(height: 12),
          _buildTrafficEditSection(
            '昨日使用',
            _ssBandwidthYesterdayUsedSizeHumanController,
            _ssBandwidthYesterdayUsedSizeRawController,
            Icons.history,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _userLevelController,
            decoration: const InputDecoration(
              labelText: '用户等级',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.star),
            ),
            keyboardType: TextInputType.number,
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _isSaving ? null : _selectDateTime,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: '等级过期时间',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              child: Text(
                _formatDateTime(_userLevelExpireIn),
                style: TextStyle(
                  color:
                      _userLevelExpireIn != null &&
                          _userLevelExpireIn!.isBefore(DateTime.now())
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nodeSpeedLimitRawController,
            decoration: const InputDecoration(
              labelText: '连接限速 (Mbps)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.speed),
              helperText: '单位: Mbps，支持小数，留空为不限速',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nodeConnectorController,
            decoration: const InputDecoration(
              labelText: '连接数量',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.link),
            ),
            keyboardType: TextInputType.number,
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _autoResetDayController,
            decoration: const InputDecoration(
              labelText: '管理员设置重置日',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.event_repeat),
              helperText: '每月重置流量的日期（1-31），留空为未启用',
            ),
            keyboardType: TextInputType.number,
            enabled: !_isSaving,
          ),
          const SizedBox(height: 12),
          _buildTrafficEditSection(
            '管理员设置自动重置流量值',
            _autoResetBandwidthHumanController,
            _autoResetBandwidthRawController,
            Icons.autorenew,
          ),
        ],
      );
    }

    // Display mode
    final usedBytes = service.ssUploadSize + service.ssDownloadSize;
    final totalBytes = service.ssBandwidthTotalSize;
    final remainingBytes = totalBytes - usedBytes;
    final usagePercent = totalBytes > 0 ? (usedBytes / totalBytes * 100) : 0.0;

    return Column(
      children: [
        _buildTrafficProgress(usedBytes, totalBytes, usagePercent),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.upload, '上传流量', formatBytes(service.ssUploadSize)),
        _buildInfoRow(
          Icons.download,
          '下载流量',
          formatBytes(service.ssDownloadSize),
        ),
        _buildInfoRow(
          Icons.data_usage,
          '总流量限制',
          formatBytes(service.ssBandwidthTotalSize),
        ),
        _buildInfoRow(
          Icons.trending_down,
          '剩余流量',
          formatBytes(remainingBytes),
          valueColor: remainingBytes < 1073741824 ? Colors.red : null,
        ),
        _buildInfoRow(
          Icons.history,
          '昨日使用',
          formatBytes(service.ssBandwidthYesterdayUsedSize),
        ),
        const Divider(height: 24),
        _buildInfoRow(Icons.star, '用户等级', service.userLevel.toString()),
        _buildInfoRow(
          Icons.calendar_today,
          '等级过期时间',
          _formatDateTime(service.userLevelExpireIn),
          valueColor:
              service.userLevelExpireIn.toLocal().isBefore(DateTime.now())
              ? Colors.red
              : Colors.green,
        ),
        // nodeSpeedLimit 是 String? 类型
        if (service.nodeSpeedLimit != null &&
            service.nodeSpeedLimit!.isNotEmpty)
          () {
            final speedLimit = num.tryParse(service.nodeSpeedLimit!);
            if (speedLimit != null && speedLimit > 0) {
              return _buildInfoRow(
                Icons.speed,
                '连接限速',
                '${speedLimit.toStringAsFixed(2)} Mbps',
                valueColor: Colors.blue,
              );
            } else {
              return _buildInfoRow(
                Icons.speed,
                '连接限速',
                '不限速',
                valueColor: Colors.grey,
              );
            }
          }()
        else
          _buildInfoRow(Icons.speed, '连接限速', '不限速', valueColor: Colors.grey),
        _buildInfoRow(
          Icons.link,
          '连接数量',
          service.nodeConnector != null
              ? service.nodeConnector.toString()
              : '不限制',
          valueColor: service.nodeConnector == null ? Colors.grey : null,
        ),
        if (service.autoResetDay != null && service.autoResetDay! > 0)
          _buildInfoRow(
            Icons.event_repeat,
            '管理员设置重置日',
            '每月${service.autoResetDay}日',
            valueColor: Colors.blue,
          )
        else
          _buildInfoRow(
            Icons.event_repeat,
            '管理员设置重置日',
            '未启用',
            valueColor: Colors.grey,
          ),
        // autoResetBandwidth 是 String? 类型
        if (service.autoResetBandwidth != null &&
            service.autoResetBandwidth!.isNotEmpty)
          () {
            final bandwidth = num.tryParse(service.autoResetBandwidth!);
            if (bandwidth != null && bandwidth > 0) {
              return _buildInfoRow(
                Icons.autorenew,
                '管理员设置自动重置流量值',
                formatBytes(bandwidth.toInt()),
                valueColor: Colors.blue,
              );
            } else {
              return _buildInfoRow(
                Icons.autorenew,
                '管理员设置自动重置流量值',
                '未设置',
                valueColor: Colors.grey,
              );
            }
          }()
        else
          _buildInfoRow(
            Icons.autorenew,
            '管理员设置自动重置流量值',
            '未设置',
            valueColor: Colors.grey,
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

  Widget _buildTrafficEditSection(
    String label,
    TextEditingController humanController,
    TextEditingController rawController,
    IconData icon, {
    String? helperText,
  }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: humanController,
              decoration: const InputDecoration(
                labelText: '人类可读格式',
                border: OutlineInputBorder(),
                isDense: true,
                helperText: '例: 10.5 GB, 1024 MB',
              ),
              enabled: !_isSaving,
              onChanged: (value) => _syncTrafficControllers(
                humanController,
                rawController,
                value,
                true,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: rawController,
              decoration: InputDecoration(
                labelText: '原始字节数',
                border: const OutlineInputBorder(),
                isDense: true,
                helperText: helperText ?? '单位: Bytes',
              ),
              keyboardType: TextInputType.number,
              enabled: !_isSaving,
              onChanged: (value) => _syncTrafficControllers(
                humanController,
                rawController,
                value,
                false,
              ),
            ),
          ],
        ),
      ),
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
