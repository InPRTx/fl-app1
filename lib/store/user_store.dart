import 'package:fl_app1/api/export.dart';
import 'package:flutter/foundation.dart';

/// 全局用户信息缓存（单例）
///
/// 存储 Map<int, UserInfo>，并提供增删清理接口。
class UserStore extends ChangeNotifier {
  UserStore._internal();

  static final UserStore _instance = UserStore._internal();

  factory UserStore() => _instance;

  static UserStore get instance => _instance;

  final Map<int, UserInfo> _cache = <int, UserInfo>{};

  /// 读取完整的缓存视图（只读）
  Map<int, UserInfo> get cache => Map<int, UserInfo>.unmodifiable(_cache);

  /// 获取单个用户信息，找不到返回 null
  UserInfo? getUserInfo(int userId) => _cache[userId];

  /// 批量写入并通知监听者
  void putAll(Map<int, UserInfo> data) {
    _cache.addAll(data);
    notifyListeners();
  }

  /// 移除指定用户
  void evict(int userId) {
    if (_cache.remove(userId) != null) {
      notifyListeners();
    }
  }

  /// 清空缓存
  void clear() {
    if (_cache.isNotEmpty) {
      _cache.clear();
      notifyListeners();
    }
  }
}
