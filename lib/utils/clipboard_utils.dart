// filepath: /Users/inprtx/git/hub/InPRTx/fl_app1/lib/utils/clipboard_utils.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 复制文本到剪贴板
Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('已复制到剪贴板'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}
// filepath: /Users/inprtx/git/hub/InPRTx/fl_app1/lib/utils/format_utils.dart

/// 格式化字节大小为人类可读格式
String formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';

  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
  final i = (bytes.bitLength - 1) ~/ 10;
  final suffix = i < suffixes.length ? suffixes[i] : suffixes.last;
  final value = bytes / (1 << (i * 10));

  return '${value.toStringAsFixed(2)} $suffix';
}

/// 格式化日期时间
String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return '未知';

  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

/// 格式化日期
String formatDate(DateTime? dateTime) {
  if (dateTime == null) return '未知';

  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}
