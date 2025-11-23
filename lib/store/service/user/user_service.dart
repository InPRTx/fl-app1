import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/index.dart';

class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  factory UserService() => _instance;

  RestClient _restClient = createAuthenticatedClient();

  // Use global UserStore for caching
  final UserStore _userStore = UserStore();

  // Maximum number of ids per batch request
  static const int _batchSize = 200;

  /// For testing only: inject a mock RestClient
  void setRestClientForTest(RestClient client) {
    _restClient = client;
  }

  /// Fetch batch user infos for [userIds].
  ///
  /// Returns a map keyed by userId (int) to UserInfo. If the API returns
  /// string keys, they will be parsed to int when possible and ignored on parse error.
  ///
  /// Uses global UserStore for caching and parallel requests for better performance.
  ///
  /// Note: this method will not swallow exceptions; callers should handle
  /// network/auth errors according to app-wide conventions.
  Future<Map<int, UserInfo>> fetchBatchUserInfos(List<int> userIds) async {
    // Normalize requested ids and prepare result map
    final List<int> uniqueIds = userIds.toSet().toList();
    final Map<int, UserInfo> result = <int, UserInfo>{};

    // Fill from cache first
    final List<int> missing = <int>[];
    for (final id in uniqueIds) {
      final cached = _userStore.getUserInfo(id);
      if (cached != null) {
        result[id] = cached;
      } else {
        missing.add(id);
      }
    }

    if (missing.isEmpty) {
      // Return only entries requested (and present)
      return result;
    }

    // Split missing ids into batches and fetch in parallel
    final List<Future<void>> tasks = <Future<void>>[];
    for (var i = 0; i < missing.length; i += _batchSize) {
      final end = (i + _batchSize < missing.length)
          ? i + _batchSize
          : missing.length;
      final chunk = missing.sublist(i, end);

      tasks.add(_fetchBatchChunk(chunk, result));
    }

    // Wait for all parallel requests to complete
    await Future.wait(tasks);

    return result;
  }

  /// Internal: fetch a single batch chunk and update result/cache
  Future<void> _fetchBatchChunk(
    List<int> chunk,
    Map<int, UserInfo> result,
  ) async {
    final body = GetUsernamesRequest(userIds: chunk);
    final resp = await _restClient.fallback
        .getBatchUserInfosApiV2LowAdminApiUserV2BatchUserInfosPost(body: body);

    if (resp.isSuccess == true && resp.result != null) {
      final Map<int, UserInfo> newData = <int, UserInfo>{};
      resp.result!.forEach((key, value) {
        try {
          final intKey = int.parse(key);
          newData[intKey] = value;
          result[intKey] = value;
        } catch (_) {
          // ignore keys that cannot be parsed to int
        }
      });

      // Write to global store
      if (newData.isNotEmpty) {
        _userStore.putAll(newData);
      }
    }
  }

  /// Clear all cached user info
  void clearCache() {
    _userStore.clear();
  }

  /// Evict a specific user from cache
  void evict(int userId) {
    _userStore.evict(userId);
  }

  /// Compute Gravatar URL for [email]. Returns null if [email] is null or empty.
  ///
  /// Uses MD5 of trimmed lower-cased email and returns a URL with size [size]
  /// and default identicon.
  String? gravatarUrlForEmail(String? email, {int size = 80}) {
    if (email == null) return null;
    final trimmed = email.trim().toLowerCase();
    if (trimmed.isEmpty) return null;

    final bytes = utf8.encode(trimmed);
    final digest = md5.convert(bytes).toString();
    return 'https://www.gravatar.com/avatar/$digest?s=$size&d=identicon';
  }
}
