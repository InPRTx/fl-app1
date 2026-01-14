@JS()
library pow_service_web_wasm;

import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'pow_service_web.dart' as fallback;

/// POW 计算服务 - Web 平台实现（WASM优化版）
///
/// 优先使用 WASM 模块进行高性能计算
/// 如果 WASM 不可用，回退到纯 Dart 实现

/// Window对象扩展，用于访问自定义属性
extension type WindowExt._(JSObject _) implements JSObject {
  external bool? get __powWasmReady;

  external POWSolverJS? get POWSolver;
}

/// WASM POW求解器JS接口
extension type POWSolverJS._(JSObject _) implements JSObject {
  external POWSolverJS(JSString capId, JSNumber difficulty);

  external JSArray<JSNumber> solve_all(JSNumber challengeCount);

  external JSArray<JSNumber> solve_batch(JSNumber startIndex, JSNumber count);
}

/// 检查WASM是否已加载
bool _isWasmLoaded() {
  try {
    final WindowExt windowExt = web.window as WindowExt;
    return windowExt.__powWasmReady == true;
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
      // 使用WASM计算
      return await _computeWithWasm(
        capId: capId,
        challengeCount: challengeCount,
        difficulty: difficulty,
        onProgress: onProgress,
      );
    } catch (e) {
      // WASM失败，回退到Dart
      web.console.warn('WASM computation failed: $e, using fallback'.toJS);
    }
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
  final WindowExt windowExt = web.window as WindowExt;
  final POWSolverJS? solverConstructor = windowExt.POWSolver;

  if (solverConstructor == null) {
    throw Exception('POWSolver not found in window');
  }

  // 创建WASM求解器实例
  final POWSolverJS solver = POWSolverJS(capId.toJS, difficulty.toJS);

  // 如果没有进度回调，直接计算全部
  if (onProgress == null) {
    final JSArray<JSNumber> result = solver.solve_all(challengeCount.toJS);
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

    final JSArray<JSNumber> batchResult = solver.solve_batch(
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
List<int> _convertJSArrayToList(JSArray<JSNumber> jsArray) {
  final List<int> result = <int>[];

  try {
    final int length = jsArray.length;

    for (int i = 0; i < length; i++) {
      final JSNumber? item = jsArray[i];
      if (item != null) {
        result.add(item.toDartInt);
      }
    }
  } catch (e) {
    web.console.warn('Failed to convert JS array: $e'.toJS);
  }

  return result;
}
