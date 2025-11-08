import 'package:fl_app1/api/models/admin_old_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class UserOldServiceCardComponent extends StatelessWidget {
  final AdminOldService? serviceData;

  const UserOldServiceCardComponent({super.key, required this.serviceData});

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

  double _calculateUsagePercent() {
    if (serviceData == null || serviceData!.ssBandwidthTotalSize == 0) {
      return 0.0;
    }
    final used = serviceData!.ssUploadSize + serviceData!.ssDownloadSize;
    return (used / serviceData!.ssBandwidthTotalSize).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    if (serviceData == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无服务信息', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    final service = serviceData!;
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

            // 流量使用情况
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

            _buildInfoRow('上传流量', _formatBytes(service.ssUploadSize)),
            _buildInfoRow('下载流量', _formatBytes(service.ssDownloadSize)),
            _buildInfoRow(
              '昨日使用',
              _formatBytes(service.ssBandwidthYesterdayUsedSize),
            ),
            _buildInfoRow('用户等级', 'Level ${service.userLevel}'),
            _buildInfoRow(
              '等级过期时间',
              _formatDateTime(service.userLevelExpireIn),
              valueColor:
                  service.userLevelExpireIn.isBefore(
                    tz.TZDateTime.now(tz.local),
                  )
                  ? Colors.red
                  : Colors.green,
            ),
            _buildInfoRow('最后使用时间', _formatDateTime(service.ssLastUsedTime)),
            _buildInfoRow('最后签到时间', _formatDateTime(service.lastCheckInTime)),
            _buildInfoRow(
              '在线设备数',
              service.nodeConnector != null
                  ? service.nodeConnector.toString()
                  : '不限制',
            ),
            _buildInfoRow(
              '节点速率限制',
              service.nodeSpeedLimit != null &&
                      service.nodeSpeedLimit!.isNotEmpty
                  ? () {
                      final speedLimit = num.tryParse(service.nodeSpeedLimit!);
                      return speedLimit != null && speedLimit > 0
                          ? '${speedLimit.toStringAsFixed(2)} Mbps'
                          : '无限制';
                    }()
                  : '无限制',
            ),
            _buildInfoRow(
              '自动重置日',
              service.autoResetDay != null && service.autoResetDay! > 0
                  ? '每月 ${service.autoResetDay} 日'
                  : '未设置',
            ),
            _buildInfoRow(
              '重置流量值',
              service.autoResetBandwidth != null &&
                      service.autoResetBandwidth!.isNotEmpty
                  ? () {
                      final bandwidth = num.tryParse(
                        service.autoResetBandwidth!,
                      );
                      return bandwidth != null && bandwidth > 0
                          ? _formatBytes(bandwidth.toInt())
                          : '未设置';
                    }()
                  : '未设置',
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
}
