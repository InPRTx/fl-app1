import 'dart:convert';

import 'package:crypto/crypto.dart';

/// POW 计算服务 - Web 平台实现
///
/// Web 平台不支持 Isolate，使用异步分片计算避免长时间阻塞 UI
/// 每计算一个挑战就让出控制权，确保浏览器保持响应

/// 计算 POW 解决方案（Web 版本 - 异步分片，带进度回调）
Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
  void Function(int progress, int total)? onProgress,
}) async {
  final List<int> allSolutions = <int>[];

  // 首次报告进度（0/total）
  onProgress?.call(0, challengeCount);

  // Web 平台：每计算 1 个挑战就让出控制权
  for (int i = 0; i < challengeCount; i++) {
    // 计算单个挑战的解决方案
    final int solution = _computeSingleChallenge(
      capId: capId,
      index: i,
      difficulty: difficulty,
    );

    allSolutions.add(solution);

    // 报告进度（每个挑战都报告，确保进度条流畅）
    onProgress?.call(i + 1, challengeCount);

    // 每个挑战后都让出控制权，确保浏览器不卡死
    // 使用 0ms 延迟，让事件循环有机会处理 UI 更新
    await Future<void>.delayed(Duration.zero);
  }

  return allSolutions;
}

/// 计算单个挑战的解决方案
int _computeSingleChallenge({
  required String capId,
  required int index,
  required int difficulty,
}) {
  final String target = '0' * difficulty;
  int solution = 0;

  while (true) {
    final String data = '$index$capId$solution';
    final List<int> bytes = utf8.encode(data);
    final Digest hash = sha256.convert(bytes);
    final String hashStr = hash.toString();

    if (hashStr.startsWith(target)) {
      return solution;
    }
    solution++;
  }
}
