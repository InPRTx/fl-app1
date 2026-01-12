import 'dart:convert';
import 'dart:isolate';

import 'package:crypto/crypto.dart';

/// POW验证码计算服务
///
/// 使用SHA256工作量证明算法进行验证码计算
/// 通过Isolate在后台线程执行，避免阻塞UI
class POWService {
  POWService._();

  /// 在独立isolate中计算POW解决方案
  ///
  /// [capId] 验证码UUID7
  /// [challengeCount] 挑战数量（默认80）
  /// [difficulty] 难度级别（默认4，即前导4个0）
  ///
  /// 返回计算出的solutions数组
  static Future<List<int>> computeSolutions({
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

  /// Isolate计算函数
  ///
  /// 对每个索引i (0 ~ challengeCount-1)：
  /// 1. 从solution = 0开始递增
  /// 2. 计算 SHA256("{i}{capId}{solution}")
  /// 3. 检查哈希值前difficulty位是否为0
  /// 4. 如果满足条件，记录该solution；否则继续递增
  static void _computeInIsolate(_POWParams params) {
    final List<int> solutions = <int>[];
    final String target = '0' * params.difficulty;

    for (int i = 0; i < params.challengeCount; i++) {
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
    }

    params.sendPort.send(solutions);
  }
}

/// POW计算参数
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
