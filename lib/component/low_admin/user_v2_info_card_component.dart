import 'package:fl_app1/api/models/admin_user_v.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class UserV2InfoCardComponent extends StatelessWidget {
  final AdminUserV? userData;

  const UserV2InfoCardComponent({super.key, required this.userData});

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final tz.TZDateTime localDateTime = tz.TZDateTime.from(dateTime, tz.local);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无用户信息', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    final user = userData!;

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
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow('用户 ID', user.id.toString()),
            _buildInfoRow('用户名', user.userName),
            _buildInfoRow('邮箱', user.email),
            _buildInfoRow(
              '邮箱验证',
              user.isEmailVerify ? '已验证' : '未验证',
              valueColor: user.isEmailVerify ? Colors.green : Colors.orange,
            ),
            _buildInfoRow(
              '账户状态',
              user.isEnabled ? '启用' : '禁用',
              valueColor: user.isEnabled ? Colors.green : Colors.red,
            ),
            _buildInfoRow('Telegram ID', user.tgId?.toString() ?? '未绑定'),
            _buildInfoRow('注册 IP', user.regIp?.toString() ?? 'N/A'),
            _buildInfoRow('注册时间', _formatDateTime(user.createdAt)),
            _buildInfoRow(
              '账户过期时间',
              _formatDateTime(user.userAccountExpireIn),
              valueColor:
                  user.userAccountExpireIn.isBefore(tz.TZDateTime.now(tz.local))
                  ? Colors.red
                  : Colors.green,
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
