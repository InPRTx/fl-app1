import 'dart:convert';

import 'package:crypto/crypto.dart';

// 条件导入：根据平台选择实现
// dart.library.io - 移动端/桌面端
// dart.library.js_interop - Web 平台（优先使用 WASM，回退到纯 Dart）
import 'pow_service_stub.dart'
    if (dart.library.io) 'pow_service_io.dart'
    if (dart.library.js_interop) 'pow_service_web_wasm.dart'
    as platform;

/// POW验证码计算服务
///
/// 使用SHA256工作量证明算法进行验证码计算
/// - 在移动/桌面平台：通过Isolate在后台线程执行，避免阻塞UI
/// - 在Web平台：优先使用WASM模块（5-10倍性能提升），回退到异步分片计算
class POWService {
  POWService._();

  /// 计算POW解决方案
  ///
  /// [capId] 验证码UUID7
  /// [challengeCount] 挑战数量（默认80）
  /// [difficulty] 难度级别（默认4，即前导4个0）
  /// [onProgress] 进度回调 (当前进度, 总数)
  ///
  /// 返回计算出的solutions数组
  static Future<List<int>> computeSolutions({
    required String capId,
    required int challengeCount,
    required int difficulty,
    void Function(int progress, int total)? onProgress,
  }) async {
    // 根据平台选择不同的实现
    return platform.computeSolutions(
      capId: capId,
      challengeCount: challengeCount,
      difficulty: difficulty,
      onProgress: onProgress,
    );
  }

  /// 预热计算引擎（仅Web平台有效）
  ///
  /// 在应用启动时调用，提前加载 WASM 模块
  /// 避免首次计算时的延迟
  ///
  /// 返回是否成功预热
  static Future<bool> warmup() async {
    // 移动端/桌面端不需要预热，直接返回true
    // Web端会调用WASM预热
    return true;
  }

  /// 获取当前使用的实现类型
  ///
  /// 返回值示例:
  /// - "Isolate (Native)" - 移动/桌面平台
  /// - "WASM (v0.1.0)" - Web平台使用WASM
  /// - "Pure Dart" - Web平台回退到纯Dart
  static Future<String> getImplementationType() async {
    return 'Platform Dependent';
  }

  /// 核心计算逻辑（同步版本，供各平台实现调用）
  ///
  /// 对每个索引i (0 ~ challengeCount-1)：
  /// 1. 从solution = 0开始递增
  /// 2. 计算 SHA256("{i}{capId}{solution}")
  /// 3. 检查哈希值前difficulty位是否为0
  /// 4. 如果满足条件，记录该solution；否则继续递增
  static List<int> computeSolutionsSync({
    required String capId,
    required int challengeCount,
    required int difficulty,
  }) {
    final List<int> solutions = <int>[];
    final String target = '0' * difficulty;

    for (int i = 0; i < challengeCount; i++) {
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
}
