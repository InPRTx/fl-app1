import 'dart:convert';
import 'dart:isolate';

import 'package:crypto/crypto.dart';


/// POW 计算服务 - IO 平台实现（移动端、桌面端）
///
/// 使用 Isolate 在后台线程执行 POW 计算，避免阻塞 UI

/// 计算 POW 解决方案（Isolate 版本，带进度报告）
Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
  void Function(int progress, int total)? onProgress,
}) async {
  final ReceivePort receivePort = ReceivePort();
  final ReceivePort progressPort = ReceivePort();

  // 监听进度更新
  progressPort.listen((message) {
    if (message is Map<String, int>) {
      final int current = message['current'] ?? 0;
      final int total = message['total'] ?? 0;
      onProgress?.call(current, total);
    }
  });

  await Isolate.spawn(
    _computeInIsolate,
    _POWParams(
      sendPort: receivePort.sendPort,
      progressPort: progressPort.sendPort,
      capId: capId,
      challengeCount: challengeCount,
      difficulty: difficulty,
    ),
  );

  final List<int> solutions = await receivePort.first as List<int>;

  // 关闭进度端口
  progressPort.close();

  return solutions;
}

/// Isolate 计算函数（带进度报告）
void _computeInIsolate(_POWParams params) {
  final List<int> solutions = <int>[];
  final String target = '0' * params.difficulty;

  // 报告初始进度
  params.progressPort?.send({'current': 0, 'total': params.challengeCount});

  for (int i = 0; i < params.challengeCount; i++) {
    // 计算单个挑战
    int solution = 0;
    while (true) {
      final String data = '$i${params.capId}$solution';
      final List<int> bytes = utf8.encode(data);
      final Digest hash = sha256.convert(bytes);
      final String hashStr = hash.toString();

      if (hashStr.startsWith(target)) {
        solutions.add(solution);
        break;
      }
      solution++;
    }

    // 每完成一个挑战，报告进度
    params.progressPort?.send(
        {'current': i + 1, 'total': params.challengeCount});
  }

  params.sendPort.send(solutions);
}

/// POW 计算参数（用于 Isolate 通信）
class _POWParams {
  const _POWParams({
    required this.sendPort,
    this.progressPort,
    required this.capId,
    required this.challengeCount,
    required this.difficulty,
  });

  final SendPort sendPort;
  final SendPort? progressPort;
  final String capId;
  final int challengeCount;
  final int difficulty;
}
