import 'dart:convert';

import 'package:crypto/crypto.dart';

/// POW 计算服务 - Web 平台实现
///
/// Web 平台不支持 Isolate，使用异步分片计算避免长时间阻塞 UI
/// 通过 Future.delayed 在每个挑战之间让出控制权

/// 计算 POW 解决方案（Web 版本 - 异步分片）
Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
}) async {
  // 在 Web 平台使用分片计算，每计算几个挑战就让出控制权
  const int chunkSize = 5; // 每次计算 5 个挑战
  final List<int> allSolutions = <int>[];

  for (int start = 0; start < challengeCount; start += chunkSize) {
    final int end = (start + chunkSize > challengeCount)
        ? challengeCount
        : start + chunkSize;

    // 计算这一批挑战（从 start 到 end）
    final List<int> chunkSolutions = _computeChunk(
      capId: capId,
      startIndex: start,
      endIndex: end,
      difficulty: difficulty,
    );

    allSolutions.addAll(chunkSolutions);

    // 让出控制权，避免长时间阻塞 UI
    if (end < challengeCount) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }
  }

  return allSolutions;
}

/// 计算一批挑战的解决方案
List<int> _computeChunk({
  required String capId,
  required int startIndex,
  required int endIndex,
  required int difficulty,
}) {
  final List<int> solutions = <int>[];
  final String target = '0' * difficulty;

  for (int i = startIndex; i < endIndex; i++) {
    int solution = 0;
    while (true) {
      final String data = '$i$capId$solution';
      final List<int> bytes = utf8.encode(data);
      final Digest hash = sha256.convert(bytes);
      final String hashStr = hash.toString();

      if (hashStr.startsWith(target)) {
        solutions.add(solution);
        break;
      }
      solution++;
    }
  }

  return solutions;
}
