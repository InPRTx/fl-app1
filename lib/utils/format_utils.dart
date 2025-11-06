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
