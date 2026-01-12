/// POW 计算服务 - Stub 实现
///
/// 这个文件用于条件导入的默认 stub
/// 实际不会被使用，真实平台会使用 IO 或 Web 实现

Future<List<int>> computeSolutions({
  required String capId,
  required int challengeCount,
  required int difficulty,
  void Function(int progress, int total)? onProgress,
}) async {
  throw UnsupportedError('Platform not supported');
}
