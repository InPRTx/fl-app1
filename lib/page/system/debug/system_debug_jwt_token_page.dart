import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:fl_app1/store/service/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';

@RoutePage()
class SystemDebugJwtTokenPage extends StatefulWidget {
  const SystemDebugJwtTokenPage({super.key});

  @override
  State<SystemDebugJwtTokenPage> createState() =>
      _SystemDebugJwtTokenPageState();
}

class _SystemDebugJwtTokenPageState extends State<SystemDebugJwtTokenPage> {
  final AuthStore _authStore = AuthStore();

  @override
  Widget build(BuildContext context) {
    final accessToken = _authStore.accessToken;
    final refreshToken = _authStore.refreshToken;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildTokenCard(
          title: '访问令牌 (Access Token)',
          token: accessToken,
          icon: Icons.vpn_key,
          color: Colors.blue,
        ),
        const SizedBox(height: 16),
        _buildTokenCard(
          title: '刷新令牌 (Refresh Token)',
          token: refreshToken,
          icon: Icons.refresh,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildTokenCard({
    required String title,
    required String? token,
    required IconData icon,
    required Color color,
  }) {
    if (token == null || token.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  '令牌不存在',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Map<String, dynamic>? payload;
    DateTime? expirationTime;
    Duration? remainingTime;
    bool isExpired = false;

    try {
      payload = Jwt.parseJwt(token);
      if (payload['exp'] != null) {
        expirationTime = DateTime.fromMillisecondsSinceEpoch(
          (payload['exp'] as int) * 1000,
        );
        remainingTime = expirationTime.difference(DateTime.now());
        isExpired = remainingTime.isNegative;
      }
    } catch (e) {
      debugPrint('解析 JWT 失败: $e');
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  tooltip: '复制令牌',
                  onPressed: () => _copyToClipboard(token, '$title 已复制'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              constraints: const BoxConstraints(minHeight: 120),
              child: SelectableText(
                token,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
            if (expirationTime != null) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text('令牌信息', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _buildInfoRow(
                '签发时间',
                payload?['iat'] != null
                    ? _formatDateTime(
                        DateTime.fromMillisecondsSinceEpoch(
                          (payload!['iat'] as int) * 1000,
                        ),
                      )
                    : 'N/A',
              ),
              _buildInfoRow('过期时间', _formatDateTime(expirationTime)),
              _buildInfoRow(
                '剩余时间',
                isExpired ? '已过期' : _formatDuration(remainingTime!),
              ),
              _buildInfoRow(
                '状态',
                '',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isExpired
                        ? Colors.red.withValues(alpha: 0.2)
                        : Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isExpired ? '已过期' : '有效',
                    style: TextStyle(
                      fontSize: 14,
                      color: isExpired ? Colors.red[700] : Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (payload != null) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '载荷数据 (Payload)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      tooltip: '复制载荷',
                      iconSize: 20,
                      onPressed: () => _copyToClipboard(
                        const JsonEncoder.withIndent('  ').convert(payload),
                        '载荷数据已复制',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                  constraints: const BoxConstraints(minHeight: 150),
                  child: SelectableText(
                    const JsonEncoder.withIndent('  ').convert(payload),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Expanded(
            child:
                trailing ??
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];
    if (days > 0) parts.add('$days 天');
    if (hours > 0) parts.add('$hours 小时');
    if (minutes > 0) parts.add('$minutes 分钟');
    if (seconds > 0) parts.add('$seconds 秒');

    return parts.isEmpty ? '0 秒' : parts.join(' ');
  }

  Future<void> _copyToClipboard(String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
    }
  }
}
