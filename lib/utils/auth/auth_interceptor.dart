import 'package:dio/dio.dart';
import 'package:fl_app1/utils/auth/auth_store.dart';
import 'package:flutter/foundation.dart';

/// Dio 拦截器，自动在所有请求中添加认证 token
class AuthInterceptor extends Interceptor {
  final AuthStore _authStore = AuthStore();

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
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '❌ API Error: ${err.response?.statusCode ?? 'no status'} ${err.requestOptions.path}',
    );
    debugPrint('   Error type: ${err.type}');
    debugPrint('   Message: ${err.message}');
    super.onError(err, handler);
  }
}
