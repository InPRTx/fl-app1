import 'package:dio/dio.dart';
import 'package:fl_app1/utils/auth/auth_store.dart';
import 'package:flutter/foundation.dart';

/// Dio 拦截器，自动在所有请求中添加认证 token，并在 token 过期时自动刷新
class AuthInterceptor extends Interceptor {
  final AuthStore _authStore = AuthStore();
  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authStore.accessToken;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('📤 API Request: ${options.method} ${options.path} [Auth: ✓]');
    } else {
      debugPrint('📤 API Request: ${options.method} ${options.path} [Auth: ✗]');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '📥 API Response: ${response.statusCode} ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint(
      '❌ API Error: ${err.response?.statusCode ?? 'no status'} ${err.requestOptions.path}',
    );
    debugPrint('   Error type: ${err.type}');
    debugPrint('   Message: ${err.message}');

    // 如果是 401 错误且不是刷新令牌的请求，尝试刷新令牌后重试
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('jwt_access_refresh')) {
      debugPrint('🔄 检测到 401 错误，尝试刷新令牌...');

      final refreshSuccess = await _authStore.apiRefreshToken();

      if (refreshSuccess) {
        debugPrint('🔄 令牌刷新成功，重试原始请求...');

        // 更新请求头中的 token
        final newToken = _authStore.accessToken;
        if (newToken != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        }

        // 重试原始请求
        try {
          final options = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );

          final response = await _dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: options,
          );

          debugPrint('✅ 重试请求成功: ${response.statusCode}');
          return handler.resolve(response);
        } catch (retryError) {
          debugPrint('❌ 重试请求失败: $retryError');
          return super.onError(err, handler);
        }
      } else {
        debugPrint('❌ 令牌刷新失败，返回 401 错误响应');
        // 返回一个包含错误信息的响应，而不是抛出异常
        return handler.resolve(
          Response(
            requestOptions: err.requestOptions,
            statusCode: 401,
            statusMessage: '认证失败，请重新登录',
            data: {
              'success': false,
              'message': '认证失败，请重新登录',
            },
          ),
        );
      }
    }

    super.onError(err, handler);
  }
}
