/// 格式化字节大小为人类可读格式
String formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
  final i = (bytes.bitLength - 1) ~/ 10;
  final suffix = i < suffixes.length ? suffixes[i] : suffixes.last;
  final value = bytes / (1 << (i * 10));
  return '${value.toStringAsFixed(2)} $suffix';
}

/// 解析人类可读格式的字节大小为整数
int? parseBytes(String input) {
  final trimmed = input.trim().toUpperCase();
  if (trimmed.isEmpty) return null;

  final regex = RegExp(r'^([\d.]+)\s*([KMGTP]?B?)$');
  final match = regex.firstMatch(trimmed);
  if (match == null) return null;

  final value = double.tryParse(match.group(1)!);
  if (value == null) return null;

  final unit = match.group(2)!;
  int multiplier = 1;

  if (unit.startsWith('K')) {
    multiplier = 1024;
  } else if (unit.startsWith('M')) {
    multiplier = 1024 * 1024;
  } else if (unit.startsWith('G')) {
    multiplier = 1024 * 1024 * 1024;
  } else if (unit.startsWith('T')) {
    multiplier = 1024 * 1024 * 1024 * 1024;
  } else if (unit.startsWith('P')) {
    multiplier = 1024 * 1024 * 1024 * 1024 * 1024;
  }

  return (value * multiplier).round();
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
