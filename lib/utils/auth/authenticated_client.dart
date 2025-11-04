import 'package:dio/dio.dart';
import 'package:fl_app1/api/base_url.dart';
import 'package:fl_app1/api/rest_client.dart';
import 'package:fl_app1/utils/auth/auth_store.dart';

/// Creates a REST client with authentication headers
RestClient createAuthenticatedClient() {
  final authStore = AuthStore();
  final dio = Dio(
    BaseOptions(
      baseUrl: kDefaultBaseUrl,
      headers: authStore.accessToken != null
          ? {'Authorization': 'Bearer ${authStore.accessToken}'}
          : null,
    ),
  );
  return RestClient(dio, baseUrl: kDefaultBaseUrl);
}
