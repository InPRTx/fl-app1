import 'dart:isolate';

import 'pow_service.dart';

/// POW 计算服务 - IO 平台实现（移动端、桌面端）
///
/// 使用 Isolate 在后台线程执行 POW 计算，避免阻塞 UI

/// 计算 POW 解决方案（Isolate 版本）
Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
}) async {
  final ReceivePort receivePort = ReceivePort();

  await Isolate.spawn(
    _computeInIsolate,
    _POWParams(
      sendPort: receivePort.sendPort,
      capId: capId,
      challengeCount: challengeCount,
      difficulty: difficulty,
    ),
  );

  return await receivePort.first as List<int>;
}

/// Isolate 计算函数
void _computeInIsolate(_POWParams params) {
  // 调用核心同步计算逻辑
  final List<int> solutions = POWService.computeSolutionsSync(
    capId: params.capId,
    challengeCount: params.challengeCount,
    difficulty: params.difficulty,
  );

  params.sendPort.send(solutions);
}

/// POW 计算参数（用于 Isolate 通信）
class _POWParams {
  const _POWParams({
    required this.sendPort,
    required this.capId,
    required this.challengeCount,
    required this.difficulty,
  });

  final SendPort sendPort;
  final String capId;
  final int challengeCount;
  final int difficulty;
}
