import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

import 'pow_service_web.dart' as fallback;

/// POW 计算服务 - Web 平台实现（WASM优化版 - 使用dart:js_interop_unsafe）
///
/// 优先使用 WASM 模块进行高性能计算
/// 如果 WASM 不可用，回退到纯 Dart 实现

/// 检查WASM是否已加载
bool _isWasmLoaded() {
  try {
    final JSAny? ready = (web.window as JSObject).getProperty(
        '__powWasmReady'.toJS);
    return ready?.dartify() == true;
  } catch (e) {
    return false;
  }
}

/// 计算 POW 解决方案（自动选择最佳实现）
Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
  void Function(int progress, int total)? onProgress,
}) async {
  // 检查WASM是否可用
  if (_isWasmLoaded()) {
    try {
      web.console.info('Attempting to use WASM implementation'.toJS);

      // 使用WASM计算
      return await _computeWithWasm(
        capId: capId,
        challengeCount: challengeCount,
        difficulty: difficulty,
        onProgress: onProgress,
      );
    } catch (e, stack) {
      // WASM失败，回退到Dart
      web.console.warn('WASM computation failed: $e, using fallback'.toJS);
      web.console.error('Stack: $stack'.toJS);
    }
  } else {
    web.console.info('WASM not loaded, using Dart fallback'.toJS);
  }

  // 使用纯Dart实现
  return await fallback.computeSolutions(
    capId: capId,
    challengeCount: challengeCount,
    difficulty: difficulty,
    onProgress: onProgress,
  );
}

/// 使用WASM计算POW
Future<List<int>> _computeWithWasm({
  required String capId,
  required int challengeCount,
  required int difficulty,
  void Function(int progress, int total)? onProgress,
}) async {
  // 获取POWSolver构造函数
  final JSObject windowObj = web.window as JSObject;
  final JSAny? solverConstructor = windowObj.getProperty('POWSolver'.toJS);

  if (solverConstructor == null) {
    throw Exception('POWSolver constructor not found in window');
  }

  // 创建WASM求解器实例
  final JSObject solver = (solverConstructor as JSFunction).callAsConstructor(
    capId.toJS,
    difficulty.toJS,
  ) as JSObject;

  // 如果没有进度回调，直接计算全部
  if (onProgress == null) {
    final JSAny result = solver.callMethod(
        'solve_all'.toJS, challengeCount.toJS);
    return _convertJSArrayToList(result);
  }

  // 分批计算，提供进度反馈
  const int batchSize = 10;
  final List<int> allSolutions = <int>[];

  onProgress(0, challengeCount);

  for (int i = 0; i < challengeCount; i += batchSize) {
    final int count = (i + batchSize > challengeCount)
        ? challengeCount - i
        : batchSize;

    final JSAny batchResult = solver.callMethod(
      'solve_batch'.toJS,
      i.toJS,
      count.toJS,
    );

    final List<int> batch = _convertJSArrayToList(batchResult);
    allSolutions.addAll(batch);

    onProgress(i + count, challengeCount);

    // 让出控制权
    await Future<void>.delayed(Duration.zero);
  }

  return allSolutions;
}

/// 转换JS数组为Dart List
List<int> _convertJSArrayToList(JSAny jsArray) {
  final List<int> result = <int>[];

  try {
    final JSObject arrayObj = jsArray as JSObject;
    final int length = (arrayObj.getProperty('length'.toJS) as JSNumber)
        .toDartInt;

    for (int i = 0; i < length; i++) {
      final JSAny? item = arrayObj.getProperty(i.toJS);
      if (item != null && item is JSNumber) {
        result.add(item.toDartInt);
      }
    }
  } catch (e) {
    web.console.warn('Failed to convert JS array: $e'.toJS);
  }

  return result;
}

