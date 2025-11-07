import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/store/service/auth/auth_interceptor.dart';

/// Creates a REST client with authentication interceptor
RestClient createAuthenticatedClient() {
  final dio = Dio(BaseOptions(baseUrl: kDefaultBaseUrl));

  // 添加认证拦截器，自动在所有请求中添加 token 并处理 token 过期自动刷新
  dio.interceptors.add(AuthInterceptor(dio));

  return RestClient(dio, baseUrl: kDefaultBaseUrl);
}
