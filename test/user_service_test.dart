import 'package:dio/dio.dart';
import 'package:fl_app1/api/export.dart';
import 'package:fl_app1/store/index.dart';
import 'package:flutter_test/flutter_test.dart';

// Simple test stub for RestClient using noSuchMethod
class TestRestClient extends RestClient {
  TestRestClient(this._mockFallback) : super(Dio());

  final TestFallbackClient _mockFallback;

  @override
  FallbackClient get fallback => _mockFallback;
}

class TestFallbackClient extends Fake implements FallbackClient {
  TestFallbackClient();

  final Map<String, GetUserInfosResponse> _responses = {};

  void setMockResponse(List<int> userIds, GetUserInfosResponse response) {
    _responses[userIds.join(',')] = response;
  }

  @override
  Future<GetUserInfosResponse>
  getBatchUserInfosApiV2LowAdminApiUserV2BatchUserInfosPost({
    required GetUsernamesRequest body,
  }) async {
    final key = body.userIds.join(',');
    return _responses[key] ?? const GetUserInfosResponse(result: {});
  }
}

void main() {
  late UserService service;
  late TestFallbackClient mockFallback;
  late TestRestClient mockClient;

  setUp(() {
    service = UserService();
    mockFallback = TestFallbackClient();
    mockClient = TestRestClient(mockFallback);
    service.setRestClientForTest(mockClient);

    // Clear global cache before each test
    UserStore().clear();
  });

  group('UserService', () {
    test('fetchBatchUserInfos fetches and caches user info', () async {
      // Arrange
      mockFallback.setMockResponse(
        [1, 2],
        const GetUserInfosResponse(
          result: {
            '1': UserInfo(userName: 'Alice', email: 'alice@example.com'),
            '2': UserInfo(userName: 'Bob', email: 'bob@example.com'),
          },
        ),
      );

      // Act
      final result = await service.fetchBatchUserInfos([1, 2]);

      // Assert
      expect(result.length, 2);
      expect(result[1]?.userName, 'Alice');
      expect(result[2]?.userName, 'Bob');

      // Verify cache
      expect(UserStore().getUserInfo(1)?.userName, 'Alice');
      expect(UserStore().getUserInfo(2)?.userName, 'Bob');
    });

    test('fetchBatchUserInfos uses cache on second call', () async {
      // Arrange
      mockFallback.setMockResponse(
        [1],
        const GetUserInfosResponse(
          result: {
            '1': UserInfo(userName: 'Alice', email: 'alice@example.com'),
          },
        ),
      );

      // Act - first call
      await service.fetchBatchUserInfos([1]);

      // Clear mock to ensure no network call on second fetch
      mockFallback.setMockResponse([1], const GetUserInfosResponse(result: {}));

      // Act - second call (should use cache)
      final result = await service.fetchBatchUserInfos([1]);

      // Assert
      expect(result[1]?.userName, 'Alice');
    });

    test('clearCache removes all cached data', () async {
      // Arrange
      mockFallback.setMockResponse(
        [1],
        const GetUserInfosResponse(
          result: {
            '1': UserInfo(userName: 'Alice', email: 'alice@example.com'),
          },
        ),
      );
      await service.fetchBatchUserInfos([1]);

      // Act
      service.clearCache();

      // Assert
      expect(UserStore().getUserInfo(1), isNull);
    });

    test('evict removes single user from cache', () async {
      // Arrange
      mockFallback.setMockResponse(
        [1, 2],
        const GetUserInfosResponse(
          result: {
            '1': UserInfo(userName: 'Alice', email: 'alice@example.com'),
            '2': UserInfo(userName: 'Bob', email: 'bob@example.com'),
          },
        ),
      );
      await service.fetchBatchUserInfos([1, 2]);

      // Act
      service.evict(1);

      // Assert
      expect(UserStore().getUserInfo(1), isNull);
      expect(UserStore().getUserInfo(2)?.userName, 'Bob');
    });

    test('gravatarUrlForEmail generates correct URL', () {
      // Test with known email
      final url = service.gravatarUrlForEmail('test@example.com', size: 100);
      expect(url, isNotNull);
      expect(url, contains('gravatar.com/avatar/'));
      expect(url, contains('s=100'));
      expect(url, contains('d=identicon'));
    });

    test('gravatarUrlForEmail returns null for empty email', () {
      expect(service.gravatarUrlForEmail(null), isNull);
      expect(service.gravatarUrlForEmail(''), isNull);
      expect(service.gravatarUrlForEmail('  '), isNull);
    });

    test('gravatarUrlForEmail normalizes email (trim + lowercase)', () {
      final url1 = service.gravatarUrlForEmail('Test@Example.com');
      final url2 = service.gravatarUrlForEmail('test@example.com');
      expect(url1, url2);
    });

    test(
      'fetchBatchUserInfos handles API returning non-int keys gracefully',
      () async {
        // Arrange - mock returns a key that cannot be parsed
        mockFallback.setMockResponse(
          [1],
          const GetUserInfosResponse(
            result: {
              '1': UserInfo(userName: 'Alice', email: 'alice@example.com'),
              'invalid': UserInfo(
                userName: 'Invalid',
                email: 'invalid@test.com',
              ),
            },
          ),
        );

        // Act
        final result = await service.fetchBatchUserInfos([1]);

        // Assert - only valid int key should be present
        expect(result.length, 1);
        expect(result[1]?.userName, 'Alice');
      },
    );
  });
}
